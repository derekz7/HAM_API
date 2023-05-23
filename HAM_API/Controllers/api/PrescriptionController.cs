using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using HAM_API.Models;

namespace HAM_API.Controllers.api
{
    public class PrescriptionController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Prescription
        public IQueryable<tbl_prescription> GetAllPrescriptions()
        {
            return db.tbl_prescription;
        }

        // GET: api/Prescription/5
        [ResponseType(typeof(tbl_prescription))]
        public IHttpActionResult GetPrescriptionById(string id)
        {
            tbl_prescription tbl_prescription = db.tbl_prescription.Find(id);
            if (tbl_prescription == null)
            {
                return NotFound();
            }

            return Ok(tbl_prescription);
        }

        [HttpGet]
        public List<tbl_prescription> GetPrescriptionByUser(string userid)
        {
            List<tbl_prescription> prescriptions = db.tbl_prescription.Where(e => e.user_id == userid).ToList();
            return prescriptions;
        }


        // PUT: api/Prescription/5
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdatePrescription(string id, tbl_prescription tbl_prescription)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_prescription.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_prescription).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_prescriptionExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Prescription
        [ResponseType(typeof(tbl_prescription))]
        public IHttpActionResult CreatePrescription(tbl_prescription tbl_prescription)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_prescription.Add(tbl_prescription);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_prescriptionExists(tbl_prescription.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_prescription.id }, tbl_prescription);
        }

        // DELETE: api/Prescription/5
        [ResponseType(typeof(tbl_prescription))]
        public IHttpActionResult DeletePrescription(string id)
        {
            tbl_prescription tbl_prescription = db.tbl_prescription.Find(id);
            if (tbl_prescription == null)
            {
                return NotFound();
            }

            db.tbl_prescription.Remove(tbl_prescription);
            db.SaveChanges();

            return Ok(tbl_prescription);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_prescriptionExists(string id)
        {
            return db.tbl_prescription.Count(e => e.id == id) > 0;
        }
    }
}