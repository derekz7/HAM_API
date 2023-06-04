namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_booking
    {
        [StringLength(20)]
        public string id { get; set; }

        public int? order_num { get; set; }

        [StringLength(20)]
        public string date { get; set; }

        [StringLength(20)]
        public string time { get; set; }

        public int? price { get; set; }

        [StringLength(100)]
        public string status { get; set; }

        [StringLength(20)]
        public string pt_id { get; set; }

        [StringLength(20)]
        public string user_id { get; set; }

        [StringLength(20)]
        public string dc_id { get; set; }

        [StringLength(20)]
        public string sv_id { get; set; }


        [StringLength(200)]
        public string note { get; set; }

        public virtual tbl_doctor tbl_doctor { get; set; }

        public virtual tbl_patient tbl_patient { get; set; }

        public virtual tbl_service tbl_service { get; set; }

        public virtual tbl_user tbl_user { get; set; }
    }
}
