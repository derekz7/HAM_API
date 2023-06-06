namespace HAM_API.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tbl_patient
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tbl_patient()
        {
            tbl_booking = new HashSet<tbl_booking>();
            tbl_patientRelative = new HashSet<tbl_patientRelative>();
        }

        [StringLength(20)]
        public string id { get; set; }

        [StringLength(100)]
        public string pt_name { get; set; }

        [StringLength(10)]
        public string dob { get; set; }

        [StringLength(10)]
        public string gender { get; set; }

        [StringLength(100)]
        public string job { get; set; }

        [StringLength(300)]
        public string address { get; set; }

        [StringLength(20)]
        public string user_id { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_booking> tbl_booking { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tbl_patientRelative> tbl_patientRelative { get; set; }

        public virtual tbl_user tbl_user { get; set; }
    }
}
