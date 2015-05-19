using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Scada.Data;
using Utils;
using MySql.Data.MySqlClient;



namespace Scada.Server.Module
{
    
    /// <summary>
    /// Struct that contains channel number, channel data and current time
    /// </summary>
    struct ChannelValueObject
    {        
        public ChannelValueObject(int _cnl, SrezTableLight.CnlData _data, DateTime _time)
        {
            cnl = _cnl;
            data = _data;
            time = _time;
        }

        public int cnl;
        public SrezTableLight.CnlData data;
        public DateTime time;
    }

    public class ModDbManagerLogic : Scada.Server.Module.ModLogic
    {

        const int WAIT_FOR_STOP = 2000;
        private Object lockObject;        
        private Queue< ChannelValueObject > commQueue;
        private Thread dbThread;

        const string DB_NAME = "test";
        const string DB_HOST = "localhost";
        const string DB_USER = "root";
        const string DB_PASS = "23021995";
        
        string DB_CONNECT_STRING = String.Format("Database={0}; Server={1}; Uid={2}; Pwd={3};", DB_NAME, DB_HOST, DB_USER, DB_PASS);
        const string DB_TABLE_NAME = "scadatest";

        MySqlConnection myConnection;

        public ModDbManagerLogic()
        {            
            commQueue = new Queue< ChannelValueObject >();
            lockObject = new Object();
            myConnection = new MySqlConnection(DB_CONNECT_STRING);            

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
                    if (commQueue.Count > 0)
                    {
                        myConnection.Open();
                        while (commQueue.Count > 0)
                        {
                            ChannelValueObject cvo = commQueue.Dequeue();
                            string query = String.Format("INSERT INTO {0} ('time', 'channel', 'value') VALUES ({1}, {2}, {3});", DB_TABLE_NAME, cvo.time, cvo.cnl, cvo.data.Val);
                            MySqlCommand myCommand = new MySqlCommand(query, myConnection);
                            myCommand.ExecuteNonQuery();
                        }
                        myConnection.Close();
                    }
                }
            }
        }

        public override string Name
        {
            get { return "DbManager"; }
        }

        public override void OnServerStart()
        {
            base.OnServerStart();
            dbThread = new Thread(new ThreadStart(DoDbWork));
            dbThread.Start();
            WriteToLog(String.Format("Module {0} started.", Name), Log.ActTypes.Information);
        }

        public override void OnServerStop()
        {
            if (dbThread.Join(WAIT_FOR_STOP))
            {
                WriteToLog(String.Format("Module {0} stopped.", Name), Log.ActTypes.Information);
            }
            else
            {
                dbThread.Abort();
                WriteToLog(String.Format("Module {0} aborted.", Name), Log.ActTypes.Information);
            }
            base.OnServerStop();
        }

        public override void OnCurDataProcessed(int[] cnlNums, SrezTableLight.Srez curSrez)
        {

            myConnection = new MySqlConnection(DB_CONNECT_STRING);

            base.OnCurDataProcessed(cnlNums, curSrez);
            foreach (int cnl in cnlNums) 
            {
                SrezTableLight.CnlData data;
                if (curSrez.GetCnlData(cnl, out data))
                {
                    lock (lockObject)
                    {
                        commQueue.Enqueue(new ChannelValueObject(cnl, data, DateTime.Now));
                    }
                }
            }
        }
    }
}
