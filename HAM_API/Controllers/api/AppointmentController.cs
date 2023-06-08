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
    public class AppointmentController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Appointment
        public IQueryable<tbl_appointment> GetAllAppointments()
        {
            return db.tbl_appointment;
        }

        public List<tbl_appointment> GetAppointmentsbyDoctor(string doctorId)
        {
            List<tbl_appointment> apps = db.tbl_appointment.ToList();
            List<tbl_booking> books = db.tbl_booking.ToList();

            List<tbl_appointment> appointment = (from app in apps
                                                 join booking in books on app.bid equals booking.id
                                                 where booking.dc_id == doctorId && booking.status == "Chờ khám"
                                                 select app).ToList();
            return appointment;
        }


        public List<tbl_appointment> getAllBookingToday(string doctorId)
        {
            List<tbl_appointment> currentDateBook = new List<tbl_appointment>();
            DateTime currentDate = DateTime.Now.Date;
            List<tbl_appointment> booking = db.tbl_appointment.Where(x => x.status == "Chờ khám").ToList();
            foreach (tbl_appointment item in booking)
            {
                if (DateTime.ParseExact(item.date, "d/M/yyyy", null) == currentDate)
                {
                    currentDateBook.Add(item);
                }
            }
            return currentDateBook;
        }

        // GET: api/Appointment/5
        [ResponseType(typeof(tbl_appointment))]
        public IHttpActionResult GetAppointmentById(string id)
        {
            tbl_appointment tbl_appointment = db.tbl_appointment.Find(id);
            if (tbl_appointment == null)
            {
                return NotFound();
            }

            return Ok(tbl_appointment);
        }

        public List<tbl_appointment> GetAppointmentsByUser(string userId)
        {
            return db.tbl_appointment.Where(x => x.uid == userId).ToList();
        }

        [ResponseType(typeof(tbl_appointment))]
        public IHttpActionResult GetAppointmentByBid(string bid)
        {
            tbl_appointment tbl_appointment = db.tbl_appointment.Find(bid);
            if (tbl_appointment == null)
            {
                return NotFound();
            }

            return Ok(tbl_appointment);
        }



        // PUT: api/Appointment/5
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateAppointment(string id, tbl_appointment tbl_appointment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_appointment.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_appointment).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_appointmentExists(id))
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

        // POST: api/Appointment
        [ResponseType(typeof(tbl_appointment))]
        public IHttpActionResult CreateAppointment(tbl_appointment tbl_appointment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tbl_appointment.Add(tbl_appointment);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_appointmentExists(tbl_appointment.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_appointment.id }, tbl_appointment);
        }

        // DELETE: api/Appointment/5
        [ResponseType(typeof(tbl_appointment))]
        public IHttpActionResult DeleteAppointment(string id)
        {
            tbl_appointment tbl_appointment = db.tbl_appointment.Find(id);
            if (tbl_appointment == null)
            {
                return NotFound();
            }

            db.tbl_appointment.Remove(tbl_appointment);
            db.SaveChanges();

            return Ok(tbl_appointment);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tbl_appointmentExists(string id)
        {
            return db.tbl_appointment.Count(e => e.id == id) > 0;
        }
    }
}