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
import javax.servlet.http.HttpSession;

import model.Cart;
import model.Tour;
import model.TourManager;

/**
 * Servlet implementation class CartController
 */
@WebServlet("/CartAddController")
public class CartAddController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartAddController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		 * -------------------------------------------- 
		 * 1. Pull data
		 * --------------------------------------------
		 */
		HttpSession session = request.getSession();
		TourManager tm = new TourManager();
		int tourid = 0;

		int isLoggedin = -1;

		try {
			isLoggedin = (int) session.getAttribute("sessUserID");
			if (isLoggedin == -1) {
				response.sendRedirect("login.jsp");
				return;
			}
		} catch (Exception ex) {
			response.sendRedirect("cart.jsp?error=addToCartErr");
			return;
		}

		try {
			tourid = Integer.parseInt(request.getParameter("tourid"));

		} catch (Exception ex) {
			ex.printStackTrace();
		}

		// System.out.println("Tour ID: " + tourid);
		/*
		 * -------------------------------------------- 
		 * 2. Validate data
		 * --------------------------------------------
		 */
		if (tourid == 0) {
			response.sendRedirect("tours?errCode=invalidTourid");
			return;
		}

		Tour result = tm.showTour(tourid);

		// check if tour exists
		if (result == null) {
			response.sendRedirect("tours?errCode=tourNotFound");
			return;

		}
		// check quantity
		if (result.getSlotsAvailable() <= 0) {
			response.sendRedirect("TourShowOneController?tourid=" + tourid + "&errCode=notEnoughSlots");
			return;
		}

		/*
		 * --------------------------------------------
		 * 3. Process request
		 * --------------------------------------------
		 */

		// session exists
		try {
			List<Cart> sessCart = (ArrayList<Cart>) request.getSession().getAttribute("sessCart");
			Cart cartItem;
			int cartTourid;
			if (sessCart != null) {
				for (int i = 0; i < sessCart.size(); i++) {
					cartItem = sessCart.get(i);
					cartTourid = cartItem.getTourId();
					// check if the tourid matches with sessionCart item
					if (cartTourid == tourid) {
						cartItem.addQuantity();

					} else {
						Cart newCartItem = new Cart();
						newCartItem.setPrice(result.getPrice());
						newCartItem.setTourId(result.getTourid());
						newCartItem.setQuantity(1);
						newCartItem.setTourName(result.getTourName());
						sessCart.add(newCartItem);
					}
					session.removeAttribute("sessCart");
					session.setAttribute("sessCart", sessCart);
					response.sendRedirect("cart.jsp");
					return;
				}
			} else {

				List<Cart> new_sessCart = new ArrayList<>();
				Cart newCartItem = new Cart();
				newCartItem.setPrice(result.getPrice());
				newCartItem.setTourId(result.getTourid());
				newCartItem.setQuantity(1);
				newCartItem.setTourName(result.getTourName());
				new_sessCart.add(newCartItem);
				session.removeAttribute("sessCart");
				session.setAttribute("sessCart", new_sessCart);
				response.sendRedirect("cart.jsp");
				return;
			}
		}
		catch (Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("TourShowOneController?tourid=" + tourid + "&errCode=unknownError");
			return;
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
