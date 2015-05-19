using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Scada.Data;
using Utils;

using System.Data;
using Npgsql;
using Mono.Security;





namespace Scada.Server.Module
{
    
    /// <summary>
    /// Struct that contains channel number, channel data and current time
    /// </summary>
    struct ChannelValueObject
    {        
        public ChannelValueObject(int _cnl, SrezTableLight.CnlData _data, DateTime _time, int _id_device, string _paramName)
        {
            cnl = _cnl;
            data = _data;
            time = _time;
            id_device = _id_device;
            paramName = _paramName;
        }

        public int cnl;
        public int id_device;
        public SrezTableLight.CnlData data;
        public DateTime time;
        public string paramName;
    }

    public class ModDbManagerLogic : Scada.Server.Module.ModLogic
    {

        const int SECONDS = 1000;
        const int WAIT_FOR_STOP = 5 * SECONDS;
        
        private Object lockObject;        
        private Queue< ChannelValueObject > dataQueue;
        private Thread dbThread;
        private Thread commandThread;

        private DataTable dataTableDevices;
        private DataTable dataTableTypes;

        const string DB_NAME = "scadatest";
        const string DB_HOST = "localhost";
        const string DB_USER = "postgres";
        const string DB_PASS = "23021995";
        
        string DB_CONNECT_STRING = String.Format("Database={0}; Server={1}; User ID={2}; Password={3};", DB_NAME, DB_HOST, DB_USER, DB_PASS);
        const string DB_TABLE_NAME = "data";

        NpgsqlConnection myConnection;
        NpgsqlConnection commConnection;

        public ModDbManagerLogic()
        {

            //NpgsqlEventLog.Level = LogLevel.Debug;
            //NpgsqlEventLog.LogName = "NpgsqlTests.LogFile";

            dataQueue = new Queue< ChannelValueObject >();
            lockObject = new Object();


            
           
            myConnection = new NpgsqlConnection(DB_CONNECT_STRING);
            commConnection = new NpgsqlConnection(DB_CONNECT_STRING);
            
            

            /*

            */


        }


        /// <summary>
        /// Method checks database, looks for not active commands
        /// </summary>
        private void CheckCommands()
        {
            while (true)
            {
                try
                {
                    commConnection.Open();



                    Command cmd = new Command(0);

                    NpgsqlTransaction transaction = commConnection.BeginTransaction();
                    try
                    {
                        string selQuery = String.Format("SELECT id_command, id_device, command_data FROM command WHERE id_command_state = 1;");
                        NpgsqlCommand cs = new NpgsqlCommand(selQuery, commConnection);
                        NpgsqlDataReader reader = cs.ExecuteReader();
                        
                        while (reader.Read())
                        {
                            int comId = reader.GetInt32(0);
                            cmd.KPNum = reader.GetInt32(1);
                            reader.GetBytes(2, 0, cmd.CmdData, 0, 40);

                            string updQuery = String.Format("UPDATE command SET id_command_state = 2 WHERE id_command = {0};", comId);
                            //probably you have to delete all previous commands for this kp
                            NpgsqlCommand cu = new NpgsqlCommand(updQuery, commConnection);
                            cu.ExecuteNonQuery();

                            PassCommand(cmd);
                        }
                        
                        transaction.Commit();
                        
                    }
                    catch (Exception e)
                    {
                        try
                        {
                            transaction.Rollback();
                        }
                        catch { }
                        WriteToLog("Transaction in CheckCommands wasn't commited. " + e.Message, Log.ActTypes.Exception);
                    }


                }
                catch (Exception e)
                {
                    WriteToLog(e.Message, Log.ActTypes.Exception);
                }
                finally
                {
                    try
                    {
                        commConnection.Close();
                    }
                    catch { }                    
                    
                }
                                
                Thread.Sleep(3 * SECONDS);
            }
        }

        /// <summary>
        /// Method checks queue, if some data exists, he writes in database
        /// </summary>
        private void DoDbWork()
        {
            while (true)
            {
                lock (lockObject)
                {
                    if (dataQueue.Count > 0)
                    {
                        try
                        {
                            myConnection.Open();                            


                            while (dataQueue.Count > 0)
                            {
                                ChannelValueObject cvo = dataQueue.Peek();
                                if (cvo.data.Stat != 0)
                                {
                                    Int32 unixTimestamp = (Int32)(cvo.time.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;

                                    string query = String.Format("INSERT INTO {0} (time, channel, value, state, id_device, descr) VALUES ('{1}', '{2}', '{3}', '{4}', '{5}', '{6}');", DB_TABLE_NAME, unixTimestamp, cvo.cnl, cvo.data.Val.ToString("0.00", new System.Globalization.CultureInfo("en-US", false)), cvo.data.Stat, cvo.id_device, cvo.paramName);

                                    NpgsqlCommand myCommand = new NpgsqlCommand(query, myConnection);
                                    NpgsqlTransaction transaction = myConnection.BeginTransaction();
                                    try
                                    {
                                        myCommand.ExecuteNonQuery();
                                        transaction.Commit();
                                        cvo = dataQueue.Dequeue();
                                    }
                                    catch (Exception e)
                                    {
                                        WriteToLog("Transaction in DoDbWork wasn't commited. " + e.Message, Log.ActTypes.Error);
                                        try
                                        {
                                            transaction.Rollback();
                                        }
                                        catch { }
                                    }
                                }
                                else
                                    cvo = dataQueue.Dequeue();
                            }

                        }
                        catch (Exception e)
                        {
                            WriteToLog(e.Message, Log.ActTypes.Exception);
                        }
                        finally
                        {
                            try
                            {
                                myConnection.Close();
                            }
                            catch { }
                        }
                    } //if
                } //lock
                Thread.Sleep(1 * SECONDS);
            } //while
        }

        public override string Name
        {
            get { return "DbManager"; }
        }

        public override void OnServerStart()
        {
            base.OnServerStart();

            //Tables initialization

            dataTableDevices = new DataTable("BaseTable");
            dataTableTypes = new DataTable("TypesTable");

            BaseAdapter adapter = new BaseAdapter();

            adapter.FileName = Settings.BaseDATDir + "incnl.dat";
            adapter.Fill(dataTableDevices, true);
            DataColumn[] primaryKeyColumns = new DataColumn[1];
            primaryKeyColumns[0] = dataTableDevices.Columns[0];
            dataTableDevices.PrimaryKey = primaryKeyColumns;
         

            adapter.FileName = Settings.BaseDATDir + "param.dat";
            adapter.Fill(dataTableTypes, true);
            primaryKeyColumns = new DataColumn[1];
            primaryKeyColumns[0] = dataTableTypes.Columns[0];
            dataTableTypes.PrimaryKey = primaryKeyColumns;



            dbThread = new Thread(new ThreadStart(DoDbWork));
            dbThread.Start();
            commandThread = new Thread(new ThreadStart(CheckCommands));
            commandThread.Start();

            WriteToLog(String.Format("Module {0} started.", Name), Log.ActTypes.Information);
        }

        public override void OnServerStop()
        {
            if (dbThread.Join(WAIT_FOR_STOP))                
            {
                if (commandThread.Join(WAIT_FOR_STOP))
                    WriteToLog(String.Format("Module {0} stopped.", Name), Log.ActTypes.Information);
                else
                {
                    dbThread.Abort();
                    commandThread.Abort();
                    WriteToLog(String.Format("Module {0} aborted.", Name), Log.ActTypes.Information);
                }
            }
            else
            {
                dbThread.Abort();
                commandThread.Abort();
                WriteToLog(String.Format("Module {0} aborted.", Name), Log.ActTypes.Information);
            }
            base.OnServerStop();
        }

       

        public override void OnCurDataProcessed(int[] cnlNums, SrezTableLight.Srez curSrez)
        {

            //WriteToLog("Entered OnCurDataProcessed " + curSrez.ToString(), Log.ActTypes.Information);
            
            base.OnCurDataProcessed(cnlNums, curSrez);
            foreach (int cnl in cnlNums) 
            {
                SrezTableLight.CnlData data;
                if (curSrez.GetCnlData(cnl, out data))
                {
                    int device;
                    string paramName;
                    try
                    {
                        DataRow searchResult = dataTableDevices.Rows.Find(cnl);
                        device = (int) searchResult["KPNum"];
                        int paramId = (int) searchResult["ParamID"];

                        searchResult = dataTableTypes.Rows.Find(paramId);
                        paramName = String.Format("{0}, {1}", (string)searchResult["Name"], (string)searchResult["Sign"]);
                    }
                    catch (Exception e)
                    {
                        continue;
                    }
                    //DataRow[] res = dataTableDevices.Select(String.Format("CnlNum = {0}", cnl));
                    
                    //if (res.Length > 0)
                    {
                        //device = (int)res[0]["KPNum"];


                        lock (lockObject)
                        {
                            dataQueue.Enqueue(new ChannelValueObject(cnl, data, DateTime.Now, device, paramName));
                        }
                    }
                }
            }
        }
    }
}
