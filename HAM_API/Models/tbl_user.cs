namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_user
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_user()
        {
            tbl_booking = new HashSet<tbl_booking>();
            tbl_doctor = new HashSet<tbl_doctor>();
            tbl_patient = new HashSet<tbl_patient>();
            tbl_prescription = new HashSet<tbl_prescription>();
        }

        [StringLength(20)]
        public string id { get; set; }

        [StringLength(100)]
        public string email { get; set; }

        [StringLength(20)]
        public string pw { get; set; }

        public int? role_id { get; set; }

        [StringLength(100)]
        public string name { get; set; }

        [Column(TypeName = "date")]
        public DateTime? dob { get; set; }

        [StringLength(10)]
        public string p_number { get; set; }

        [Column(TypeName = "text")]
        public string img { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_booking> tbl_booking { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_doctor> tbl_doctor { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_patient> tbl_patient { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_prescription> tbl_prescription { get; set; }

        public virtual tbl_role tbl_role { get; set; }
    }
}
