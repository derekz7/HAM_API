namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_prescription
    {
        [StringLength(1)]
        public string id { get; set; }

        [StringLength(1)]
        public string disease { get; set; }

        [StringLength(1)]
        public string symptoms { get; set; }

        [StringLength(1)]
        public string medicines { get; set; }

        [StringLength(1)]
        public string ptu_medicines { get; set; }

        [StringLength(1)]
        public string user_id { get; set; }

        [StringLength(1)]
        public string dc_id { get; set; }

        public virtual tbl_doctor tbl_doctor { get; set; }

        public virtual tbl_user tbl_user { get; set; }
    }
}
