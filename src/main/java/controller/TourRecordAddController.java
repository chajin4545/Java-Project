/* 
	GROUP 3
	DIT/2A/01
	HA JIN 		P2100030
	ISAAC		P2107251
	GEORGE		P2143990
 */

package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Cart;
import model.Tour;
import model.TourManager;
import model.TourRecordManager;

/**
 * Servlet implementation class TourRecordAddController
 */
@WebServlet(urlPatterns = { "/TourRecordAddController", "/admin_book" })
public class TourRecordAddController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TourRecordAddController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		/* --------------------------------------------
		 * 1. Pull data
		 * -------------------------------------------- */

		List<Cart> cart = (ArrayList<Cart>) request.getSession().getAttribute("sessCart");
		TourRecordManager trm = new TourRecordManager();

		int tourID = 0;
		int userID = 0;
		int qty = 0;

		String source = "checkout.jsp";

		// ADMIN BOOKING FOR USER
		if (request.getRequestURI().contains("admin_book")) {
			source = "admin_user";
			int userid = -1;
			int tourid = -1;
			int quantity = -1;
			try {
				userid = Integer.parseInt(request.getParameter("adminbook_userid"));
				tourid = Integer.parseInt(request.getParameter("adminbook_tourid"));
				quantity = Integer.parseInt(request.getParameter("adminbook_quantity"));

				if (quantity <= 0) {
					response.sendRedirect(source + "?errCode=quantityError");
					return;
				}
				TourManager tm = new TourManager();
				Tour res = tm.showTour(tourid);

				if (res != null && res.getSlotsAvailable() < quantity) {
					response.sendRedirect(source + "?errCode=notEnoughSlots");
					return;

				} else if (res == null) {
					response.sendRedirect(source + "?errCode=tourNotFound");
					return;
				}

				List<Cart> cartList = new ArrayList<Cart>();
				Cart tempCart = new Cart(quantity, tourid);
				cartList.add(tempCart);
				int[] result = trm.addRecord(cartList, userid);

				if (result[0] != -1) {
					tm.updateTourSlots(tourid, quantity);
					response.sendRedirect(source + "?message=succesfullyBooked");
					return;

				} else {
					response.sendRedirect(source + "?errCode=userNotFound");
					return;
				}

			} catch (NumberFormatException ex) {
				ex.printStackTrace();
				response.sendRedirect(source + "?errCode=invalidNumberFormat");
				return;

			} catch (Exception ex) {

			}
		}
		// ADMIN BOOKING FOR USER END

		if (cart == null || cart.size() == 0) {
			response.sendRedirect(source + "?errCode=cartEmpty");
			return;
		}

		/* --------------------------------------------
		 * 2. Validate data
		 * -------------------------------------------- */
		List<Cart> cartList = new ArrayList<Cart>();
		userID = (int) request.getSession().getAttribute("sessUserID");

		if (userID == 0) {
			response.sendRedirect("login.jsp?errCode=userNotFound");
			return;
		}

		for (int i = 0; i < cart.size(); i++) {
			try {
				tourID = cart.get(i).getTourId();
				qty = cart.get(i).getQuantity();
				Cart tempCart = new Cart(qty, tourID);
				cartList.add(tempCart);

			} catch (NumberFormatException ex) {
				response.sendRedirect(source + "?errCode=invalidParameters");
				return;

			} catch (Exception ex) {
				response.sendRedirect(source + "?errCode=unknownError");
				return;
			}
		}

		if (cartList == null || cartList.size() == 0) {
			response.sendRedirect(source + "?errCode=unfilledParameters");
			return;
		}

		/* --------------------------------------------
		 * 3. Process request
		 * -------------------------------------------- */
		int[] result = trm.addRecord(cartList, userID);

		if (result[0] != -1) {
			response.sendRedirect("customer_history.jsp");
			return;

		} else {
			response.sendRedirect(source + "?errCode=failedTransaction");
			return;
		}
	}

}
