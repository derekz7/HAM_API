namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_doctor
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_doctor()
        {
            tbl_booking = new HashSet<tbl_booking>();
            tbl_prescription = new HashSet<tbl_prescription>();
        }

        [StringLength(20)]
        public string id { get; set; }

        [StringLength(100)]
        public string name { get; set; }

        [StringLength(100)]
        public string room { get; set; }

        [StringLength(20)]
        public string dep_id { get; set; }

        [Column(TypeName = "text")]
        public string imgUrl { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_booking> tbl_booking { get; set; }

        public virtual tbl_department tbl_department { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_prescription> tbl_prescription { get; set; }
    }
}
