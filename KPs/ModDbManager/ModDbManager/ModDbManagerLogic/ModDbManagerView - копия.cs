using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Scada.Server.Module
{
    class ModDbManagerView : Scada.Server.Module.ModView
    {

        /// <summary>
        /// Конструктор
        /// </summary>
        public ModDbManagerView()
        {
            CanShowProps = false;
        }

        public override string Descr
        {
            get { return "Database module."; }
        }
    }
}
