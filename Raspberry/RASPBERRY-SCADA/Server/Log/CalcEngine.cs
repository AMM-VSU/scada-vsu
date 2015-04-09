/*
 * Copyright 2014 Mikhail Shiryaev
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * 
 * Product  : Rapid SCADA
 * Module   : SCADA-Server Service
 * Summary  : Mechanism providing calculation of formulas
 * 
 * Author   : Mikhail Shiryaev
 * Created  : 2013
 * Modified : 2013
 */

using System;
using System.Collections.Generic;
using System.Text;
using Scada.Data;

namespace Scada.Server.Svc
{
    /// <summary>
    /// Mechanism providing calculation of formulas
    /// <para>Механизм, обеспечивающий вычисления по формулам</para>
    /// </summary>
    public class CalcEngine
    {
        /// <summary>
        /// The channel number for which the formula is calculated
        /// <para>Номер канала, для которого вычисляется формула </para>
        /// </summary>
        private int curCnlNum;
        /// <summary>
        /// Input channel data transmitted to the server before the calculation
        /// <para>Передаваемые серверу данные входного канала до расчёта</para>
        /// </summary>
        private SrezTableLight.CnlData initalCnlData;
        /// <summary>
        /// Command value transmitted to the server before the calculation
        /// <para>Передаваемое серверу значение команды управления до расчёта</para>
        /// </summary>
        private double initalCmdVal;
        /// <summary>
        /// Calculate the input channel formula flag
        /// <para>Признак вычисления формулы входного канала</para>
        /// </summary>
        private bool calcInCnl;
        /// <summary>
        /// Getting input channel data method
        /// <para>Метод получения данных входного канала</para>
        /// </summary>
        private Func<int, SrezTableLight.CnlData> getCnlData;

        
        /// <summary>
        /// Initializes a new instance of the class
        /// <para>Конструктор</para>
        /// </summary>
        public CalcEngine()
        {
            curCnlNum = -1;
            initalCnlData = SrezTableLight.CnlData.Empty;
            initalCmdVal = 0.0;
            calcInCnl = false;
            getCnlData = null;
        }

        /// <summary>
        /// Initializes a new instance of the class
        /// <para>Конструктор</para>
        /// </summary>
        public CalcEngine(Func<int, SrezTableLight.CnlData> getCnlData)
            : this()
        {
            this.getCnlData = getCnlData;
        }


        /// <summary>
        /// Gets input channel value transmitted to the server before the calculation
        /// <para>Получить передаваемое серверу значение входного канала до расчёта</para>
        /// </summary>
        public double Cnl
        {
            get
            {
                return initalCnlData.Val;
            }
        }

        /// <summary>
        /// Gets input channel value transmitted to the server before the calculation
        /// <para>Получить передаваемое серверу значение входного канала до расчёта</para>
        /// </summary>
        public double CnlVal
        {
            get
            {
                return initalCnlData.Val;
            }
        }
        
        /// <summary>
        /// Gets input channel status transmitted to the server before the calculation
        /// <para>Получить передаваемый серверу статус входного канала до расчёта</para>
        /// </summary>
        public int CnlStat
        {
            get
            {
                return initalCnlData.Stat;
            }
        }

        /// <summary>
        /// Gets command value transmitted to the server before the calculation
        /// <para>Получить передаваемое серверу значение команды управления до расчёта</para>
        /// </summary>
        public double Cmd
        {
            get
            {
                return initalCmdVal;
            }
        }

        /// <summary>
        /// Gets command value transmitted to the server before the calculation
        /// <para>Получить передаваемое серверу значение команды управления до расчёта</para>
        /// </summary>
        public double CmdVal
        {
            get
            {
                return initalCmdVal;
            }
        }

        /// <summary>
        /// Gets the channel number for which the formula is calculated
        /// <para>Получить номер канала, для которого вычисляется формула</para>
        /// </summary>
        public int CnlNum
        {
            get
            {
                return curCnlNum;
            }
        }

        /// <summary>
        /// Gets the natural logarithmic base, specified by the constant, e
        /// <para>Получить число e</para>
        /// </summary>
        public double E
        {
            get
            {
                return Math.E;
            }
        }

        /// <summary>
        /// Gets the ratio of the circumference of a circle to its diameter, specified by the constant, π
        /// <para>Получить число π</para>
        /// </summary>
        public double PI
        {
            get
            {
                return Math.PI;
            }
        }


        /// <summary>
        /// Starts the input channel data calculation
        /// <para>Начать вычисление данных входного канала</para>
        /// </summary>
        private void BeginCalcCnlData(int cnlNum, SrezTableLight.CnlData initalCnlData)
        {
            curCnlNum = cnlNum;
            this.initalCnlData = initalCnlData;
            this.initalCmdVal = 0.0;
            calcInCnl = true;
        }

        /// <summary>
        /// Ends the input channel data calculation
        /// <para>Завершить вычисление данных входного канала</para>
        /// </summary>
        private void EndCalcCnlData()
        {
            curCnlNum = -1;
            initalCnlData = SrezTableLight.CnlData.Empty;
            calcInCnl = false;
        }

        /// <summary>
        /// Starts the command value calculation
        /// <para>Начать вычисление значения команды</para>
        /// </summary>
        private void BeginCalcCmdVal(int ctrlCnlNum, double initalCmdVal)
        {
            curCnlNum = ctrlCnlNum;
            this.initalCnlData = SrezTableLight.CnlData.Empty;
            this.initalCmdVal = initalCmdVal;
        }

        /// <summary>
        /// Ends the command value calculation
        /// <para>Завершить вычисление значения команды</para>
        /// </summary>
        private void EndCalcCmdVal()
        {
            curCnlNum = -1;
            initalCmdVal = 0.0;
        }


        /// <summary>
        /// Gets the current value of the formula channel
        /// <para>Получить текущее значение канала формулы</para>
        /// </summary>
        public double Val()
        {
            return calcInCnl ? Val(curCnlNum) : SrezTableLight.CnlData.Empty.Val;
        }

        /// <summary>
        /// Gets the current value of the channel n
        /// <para>Получить текущее значение канала n</para>
        /// </summary>
        public double Val(int n)
        {
            return (getCnlData == null ? SrezTableLight.CnlData.Empty : getCnlData(n)).Val;
        }

        /// <summary>
        /// Gets the current status of the formula channel
        /// <para>Получить текущий статус канала формулы</para>
        /// </summary>
        public int Stat()
        {
            return Stat(curCnlNum);
        }

        /// <summary>
        /// Gets the current status of the channel n
        /// <para>Получить текущий статус канала n</para>
        /// </summary>
        public int Stat(int n)
        {
            return (getCnlData == null ? SrezTableLight.CnlData.Empty : getCnlData(n)).Stat;
        }

        /// <summary>
        /// Calculates the absolute value of a double-precision floating-point number
        /// <para>Вычислить модуль</para>
        /// </summary>
        public double Abs(double x)
        {
            return Math.Abs(x);
        }

        /// <summary>
        /// Calculates the sine of the specified angle
        /// <para>Вычислить синус</para>
        /// </summary>
        public double Sin(double x)
        {
            return Math.Sin(x);
        }

        /// <summary>
        /// Calculates the cosine of the specified angle
        /// <para>Вычислить косинус</para>
        /// </summary>
        public double Cos(double x)
        {
            return Math.Cos(x);
        }

        /// <summary>
        /// Calculates the tangent of the specified angle
        /// <para>Вычислить тангенс</para>
        /// </summary>
        public double Tan(double x)
        {
            return Math.Tan(x);
        }

        /// <summary>
        /// Calculates e raised to the specified power
        /// <para>Вычислить экспоненту</para>
        /// </summary>
        public double Exp(double x)
        {
            return Math.Exp(x);
        }

        /// <summary>
        /// Calculates the natural (base e) logarithm of a specified number
        /// <para>Вычислить натуральный логарифм</para>
        /// </summary>
        public double Ln(double x)
        {
            return Math.Log(x);
        }

        /// <summary>
        /// Calculates the natural (base e) logarithm of a specified number
        /// <para>Вычислить натуральный логарифм</para>
        /// </summary>
        public double Log(double x)
        {
            return Math.Log(x);
        }
        
        /// <summary>
        /// Calculates the square of a specified number
        /// <para>Возвести в квадрат</para>
        /// </summary>
        public double Sqr(double x)
        {
            return x * x;
        }

        /// <summary>
        /// Calculates the square root of a specified number
        /// <para>Вычислить квадратный корень</para>
        /// </summary>
        public double Sqrt(double x)
        {
            return Math.Sqrt(x);
        }

        #region Custom source code. Пользовательский исходный код
public bool DayBeg()
{
    DateTime nowDT = DateTime.Now;
    DateTime execDT;
    if ((nowDT.Hour == 0 && nowDT.Minute > 0 || nowDT.Hour == 1) &&
        (!DayBegDict.TryGetValue(CnlNum, out execDT) || execDT.Date < nowDT.Date))
    {
        DayBegDict[CnlNum] = nowDT;
        return true;
    }
    else
    {
        return false;
    }
}
public Dictionary<int, DateTime> DayBegDict = new Dictionary<int, DateTime>();
public bool HourBeg()
{
    DateTime nowDT = DateTime.Now;
    DateTime execDT;
    if (nowDT.Minute == 1 && (!HourBegDict.TryGetValue(CnlNum, out execDT) || 
        execDT < new DateTime(nowDT.Year, nowDT.Month, nowDT.Day, nowDT.Hour, 0, 0)))
    {
        HourBegDict[CnlNum] = nowDT;
        return true;
    }
    else
    {
        return false;
    }
}
public Dictionary<int, DateTime> HourBegDict = new Dictionary<int, DateTime>();
public bool MonthBeg()
{
    DateTime nowDT = DateTime.Now;
    DateTime execDT;
    if (nowDT.Day == 1 && (nowDT.Hour == 0 && nowDT.Minute > 0 || nowDT.Hour == 1) &&
        (!MonthBegDict.TryGetValue(CnlNum, out execDT) || execDT.Date < nowDT.Date))
    {
        MonthBegDict[CnlNum] = nowDT;
        return true;
    }
    else
    {
        return false;
    }
}
public Dictionary<int, DateTime> MonthBegDict = new Dictionary<int, DateTime>();
public double CalcCnl7Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl7Stat() { return CnlStat; }
public void CalcCnl7Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(7, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl7Val(), CalcCnl7Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl8Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl8Stat() { return CnlStat; }
public void CalcCnl8Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(8, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl8Val(), CalcCnl8Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl9Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl9Stat() { return CnlStat; }
public void CalcCnl9Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(9, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl9Val(), CalcCnl9Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl10Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl10Stat() { return CnlStat; }
public void CalcCnl10Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(10, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl10Val(), CalcCnl10Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl11Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl11Stat() { return CnlStat; }
public void CalcCnl11Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(11, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl11Val(), CalcCnl11Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl12Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl12Stat() { return CnlStat; }
public void CalcCnl12Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(12, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl12Val(), CalcCnl12Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl13Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl13Stat() { return CnlStat; }
public void CalcCnl13Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(13, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl13Val(), CalcCnl13Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl14Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl14Stat() { return CnlStat; }
public void CalcCnl14Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(14, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl14Val(), CalcCnl14Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl15Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl15Stat() { return CnlStat; }
public void CalcCnl15Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(15, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl15Val(), CalcCnl15Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl16Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl16Stat() { return CnlStat; }
public void CalcCnl16Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(16, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl16Val(), CalcCnl16Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl17Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl17Stat() { return CnlStat; }
public void CalcCnl17Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(17, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl17Val(), CalcCnl17Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl18Val() { return Convert.ToDouble(Cnl*0.001); }
public int CalcCnl18Stat() { return CnlStat; }
public void CalcCnl18Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(18, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl18Val(), CalcCnl18Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl241Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl241Stat() { return CnlStat; }
public void CalcCnl241Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(241, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl241Val(), CalcCnl241Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl242Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl242Stat() { return CnlStat; }
public void CalcCnl242Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(242, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl242Val(), CalcCnl242Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl243Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl243Stat() { return CnlStat; }
public void CalcCnl243Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(243, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl243Val(), CalcCnl243Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl244Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl244Stat() { return CnlStat; }
public void CalcCnl244Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(244, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl244Val(), CalcCnl244Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl245Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl245Stat() { return CnlStat; }
public void CalcCnl245Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(245, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl245Val(), CalcCnl245Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl246Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl246Stat() { return CnlStat; }
public void CalcCnl246Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(246, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl246Val(), CalcCnl246Stat()); } finally { EndCalcCnlData(); }}
public double CalcCnl247Val() { return Convert.ToDouble(Cnl*200/65536 - 40); }
public int CalcCnl247Stat() { return CnlStat; }
public void CalcCnl247Data(ref SrezTableLight.CnlData cnlData) { try { BeginCalcCnlData(247, cnlData); cnlData = new SrezTableLight.CnlData(CalcCnl247Val(), CalcCnl247Stat()); } finally { EndCalcCnlData(); }}
        #endregion
    }
}