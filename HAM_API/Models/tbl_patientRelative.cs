namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_patientRelative
    {
        [StringLength(20)]
        public string id { get; set; }

        [StringLength(100)]
        public string name { get; set; }

        [StringLength(300)]
        public string address { get; set; }

        [StringLength(10)]
        public string p_number { get; set; }

        [StringLength(20)]
        public string pt_id { get; set; }

        public virtual tbl_patient tbl_patient { get; set; }
    }
}
