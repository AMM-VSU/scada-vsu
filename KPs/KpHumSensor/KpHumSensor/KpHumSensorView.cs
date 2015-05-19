using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Scada.Comm.KP
{
    public sealed class KpHumSensorView : Scada.Comm.KP.KPView
    {
        public override string KPDescr
        {
            get
            {
                return "Humidity sensor KP";
            }
        }
    }
}
