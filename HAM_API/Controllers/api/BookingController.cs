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
using Microsoft.Ajax.Utilities;

namespace HAM_API.Controllers.api
{
    public class BookingController : ApiController
    {
        private DBContext db = new DBContext();

        // GET: api/Booking
        public IQueryable<tbl_booking> GetBookingList()
        {
            return db.tbl_booking;
        }

        // GET: api/Booking/5
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult GetBookingById(string id)
        {
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return NotFound();
            }

            return Ok(tbl_booking);
        }

        public List<tbl_booking> getAllBookingToday(string doctorId)
        {
            List<tbl_booking> currentDateBook = new List<tbl_booking>();
            DateTime currentDate = DateTime.Now.Date;
            List<tbl_booking> booking = db.tbl_booking.Where(x => x.status == "Chờ khám").ToList();
            foreach (tbl_booking item in booking)
            {
                if (DateTime.ParseExact(item.date,"d/M/yyyy",null) == currentDate)
                {
                    currentDateBook.Add(item);
                }
            }
            return currentDateBook;
        }

        [HttpGet]
        [Route("api/Booking/GetBookingByUsername")]
        public List<tbl_booking> getBookingByUsername(string username)
        {
            List<tbl_booking> tbl_bookings = db.tbl_booking.Where(b => b.tbl_user.username.Equals(username)).ToList();
            return tbl_bookings;
        }

        [HttpGet]
        [Route("api/Booking/GetBookingByUserId")]
        public List<tbl_booking> getBookingByUserId(string userid)
        {
            List<tbl_booking> tbl_bookings = db.tbl_booking.Where(b => b.tbl_user.id.Equals(userid)).ToList();
            return tbl_bookings;
        }

        public bool checkDateTimeBooking(tbl_booking book)
        {
            List<tbl_booking> bookings = db.tbl_booking.Where(x => x.date == book.date).ToList();
            if (bookings != null)
            {
                var check = bookings.Any(x => x.time == book.time);
                if (check)
                {
                    return false;
                }
                return true;
            }
            return true;
        }

        // PUT: api/Booking/5
        [ResponseType(typeof(void))]
        public IHttpActionResult BookingUpdate(string id, tbl_booking tbl_booking)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tbl_booking.id)
            {
                return BadRequest();
            }

            db.Entry(tbl_booking).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_bookingExists(id))
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

        [HttpPut]
        [ResponseType(typeof(void))]
        public IHttpActionResult ChangeStatus(string id, string status)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            tbl_booking booking = db.tbl_booking.Find(id) as tbl_booking;
            tbl_appointment app = db.tbl_appointment.Where(x => x.bid == id).First();
            if (booking == null)
            {
                return BadRequest();
            }
            booking.status = status;
            app.status = status;

            db.Entry(app).State = EntityState.Modified;
            db.Entry(booking).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tbl_bookingExists(id))
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



        // POST: api/Booking
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult Create(tbl_booking tbl_booking)
        {
            var check = db.tbl_booking.Any(x => x.user_id == tbl_booking.user_id && x.status == "Chờ khám");
            if (check)
            {
                return BadRequest("Vui long hoan thanh lich kham cua ban");
            }
            tbl_booking.status = "Chờ khám";
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            string idap = "ap-" + Guid.NewGuid().ToString("N").Substring(0, 17);
            tbl_doctor dc = db.tbl_doctor.Find(tbl_booking.dc_id);
            tbl_service sv = db.tbl_service.Find(tbl_booking.sv_id);
            tbl_patient pt = db.tbl_patient.Find(tbl_booking.pt_id);
            tbl_appointment apointment = new tbl_appointment();
            apointment.id = idap;
            apointment.bid = tbl_booking.id;
            apointment.uid = tbl_booking.user_id;
            apointment.dcid = tbl_booking.dc_id;
            apointment.dcName = dc.name;
            apointment.time = tbl_booking.time;
            apointment.date = tbl_booking.date;
            apointment.price = tbl_booking.price;
            apointment.ptName = pt.pt_name;
            apointment.orderNum = tbl_booking.order_num;
            apointment.serviceName = sv.name;
            apointment.room = dc.room;
            apointment.status = tbl_booking.status;
            apointment.depName = dc.tbl_department.name;
            db.tbl_appointment.Add(apointment);
            db.tbl_booking.Add(tbl_booking);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (tbl_bookingExists(tbl_booking.id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = tbl_booking.id }, tbl_booking);
        }

        // DELETE: api/Booking/5
        [ResponseType(typeof(tbl_booking))]
        public IHttpActionResult Delete(string id)
        {
            tbl_booking tbl_booking = db.tbl_booking.Find(id);
            if (tbl_booking == null)
            {
                return NotFound();
            }

            db.tbl_booking.Remove(tbl_booking);
            db.SaveChanges();

            return Ok(tbl_booking);
        }

        [ResponseType(typeof(tbl_appointment))]
        public IHttpActionResult getAppointmentByBid(string bid)
        {
            tbl_appointment tbl_appointment = db.tbl_appointment.Where(a => a.bid == bid).First();
            if (tbl_appointment == null)
            {
                return NotFound();
            }

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

        private bool tbl_bookingExists(string id)
        {
            return db.tbl_booking.Count(e => e.id == id) > 0;
        }
    }
}