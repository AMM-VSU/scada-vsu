using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Scada.Comm.KP;
using Scada.Data;


namespace Scada.Comm.KP
{
    public sealed class KpHumSensorLogic : KPLogic
    {
        private Random random;

        public KpHumSensorLogic(int number)
            : base(number)
        {
            random = new Random();
            

            ReqParams temp = KPReqParams;
            temp.CmdLine = @"/dev/rfcomm1";
            KPReqParams = temp;

            InitArrays(3, 1);
            ParamGroup group;
            group = new ParamGroup("Humidity&Temp", 3);
            group.KPParams[0] = new Param(1, "Humidity");
            group.KPParams[1] = new Param(2, "Temperature");
            group.KPParams[2] = new Param(3, "Status");
            ParamGroups[0] = group;


            CopyParamsFromGroups();
        }

        public override void Session()
        {
            base.Session();

            int temperature = -1;
            int humidity = -1;
            int status = -1; //-1 - device off; 0 - device ok, data bad; 1 - device ok, data ok

            if (SerialPort == null)
            {
                WriteToLog(KPUtils.WriteDataImpossible);
                Thread.Sleep(KPReqParams.Delay);
                lastCommSucc = false;
            }
            else
            {
                // write to the serial port
                // запись в последовательный порт
                string outStr = "request";
                SerialPort.WriteLine(outStr);
                WriteToLog("Send: " + outStr);

                // read from the serial port
                // чтение из последовательного порта
                string buf = SerialPort.ReadExisting();
                if (buf == null || buf == "")
                {
                    WriteToLog("Receive: no data");
                    lastCommSucc = false;
                }
                else
                {
                    status = 0;
                    WriteToLog("Receive: " + buf);
                    string[] res = buf.Split(';');
                    if (res.Length == 4)
                        if (res[0] == "ok")
                        {
                            humidity = Int32.Parse(res[2]);
                            temperature = Int32.Parse(res[1]);
                            if (humidity + temperature == Int32.Parse(res[3]))
                                status = 1;
                        }
                }

                // finish request
                // завершение запроса
                FinishRequest();
            }

            // generate current data
            // генерация текущих значений
            
            SetParamData(0, humidity, status);
            SetParamData(1, temperature, status);

            if (status == -1)
                SetParamData(2, 0, 0);
            else
                SetParamData(2, random.Next(10), 1);


            // calculate stats
            // расчёт статистики
            CalcSessStats();
        }

        public override void SendCmd(Command cmd)
        {
            base.SendCmd(cmd);
            CalcCmdStats();
        }


    }
}
