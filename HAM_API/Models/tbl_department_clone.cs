namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_department_clone
    {
        [StringLength(20)]
        public string id { get; set; }

        [StringLength(200)]
        public string name { get; set; }

        [StringLength(500)]
        public string description { get; set; }

        [Column(TypeName = "text")]
        public string img { get; set; }
    }
}
