/* 
	GROUP 3
	DIT/2A/01
	HA JIN 		P2100030
	ISAAC		P2107251
	GEORGE		P2143990
 */

package model;

public class Cart {
	private String tourName;
	private double price;
	private double totalPrice;
	private String picUrl;
	private int quantity;
	private int tourId;

	public Cart() {

	}

	public Cart(int quantity, int tourId) {
		this.quantity = quantity;
		this.tourId = tourId;
	}

	public String getTourName() {
		return tourName;
	}

	public void setTourName(String tourName) {
		this.tourName = tourName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTourId() {
		return tourId;
	}

	public void setTourId(int tourId) {
		this.tourId = tourId;
	}

	public double getTotalPrice() {
		totalPrice = price * quantity;
		return totalPrice;
	}

	public void addQuantity() {
		quantity += 1;
	}

	public void minusQuantity() {
		quantity -= 1;
	}
}
