package pack_JDBC;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import pack_Bean.BasketBean;
import pack_Bean.ProductBean;
import pack_DBCP.DBConnectionMgr;
import pack_Util.UtilMgr;

public class BasketMgr {

	private DBConnectionMgr pool;

	public BasketMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/// 장바구니 추가 시작///
	public boolean insertBasket(HttpServletRequest request) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;

		try {
			conn = pool.getConnection();
			request.setCharacterEncoding("utf-8");

			sql = "insert into tblBasket " + " (id, productName, price, productNum, "
					+ " quantity, buy, buydate, productType ) values (?, ?, ?, ?, ?, 0, now(), ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("id"));
			pstmt.setString(2, request.getParameter("productName"));
			pstmt.setString(3, request.getParameter("price"));
			pstmt.setInt(4, Integer.parseInt(request.getParameter("productNum")));
			pstmt.setInt(5, Integer.parseInt(request.getParameter("quantity")));
			pstmt.setString(6, request.getParameter("productType"));

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}

		return flag;
	}
	/// 장바구니 추가 끝 ///

	/// 장바구니 수정 시작 ///
	public boolean updateBasket(int basketNum, int quantity) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			conn = pool.getConnection();
			sql = "update tblBasket set quantity=? where basketNum=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, quantity);
			pstmt.setInt(2, basketNum);

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return flag;
	}
	/// 장바구니 수정 끝 ///

	/// 장바구니 반환 시작 ///
	public BasketBean getBasket(int basketNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BasketBean bean = new BasketBean();
		try {
			conn = pool.getConnection();
			sql = "select * from tblBasket where basketNum=? and buy=0";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, basketNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setProductName(rs.getString("productName"));
				bean.setPrice(rs.getString("price"));
				bean.setProductNum(rs.getInt("productNum"));
				bean.setBasketNum(rs.getInt("basketNum"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setBuy(rs.getInt("buy"));
				bean.setBuydate(rs.getString("buydate"));
				bean.setProductType(rs.getString("productType"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return bean;
	}

	/// 장바구니 목록 반환 시작 ///
	public Vector<BasketBean> getBasketList(String id, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BasketBean> vlist = new Vector<>();
		try {
			conn = pool.getConnection();
			if (id.equals("admin")) {
				sql = "select * from tblBasket order by basketNum desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, start);
				
			} else {
				sql = "select * from  tblBasket where id=? ";
				sql +=" order by basketNum desc limit ?, ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BasketBean bean = new BasketBean();
				bean.setId(rs.getString("id"));
				bean.setProductName(rs.getString("productName"));
				bean.setPrice(rs.getString("price"));
				bean.setProductNum(rs.getInt("productNum"));
				bean.setBasketNum(rs.getInt("basketNum"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setBuy(rs.getInt("buy"));
				bean.setBuydate(rs.getString("buydate"));
				bean.setProductType(rs.getString("productType"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return vlist;
	}

	/// 장바구니 목록 총 개수 반환 시작
	public int getTotalCount(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			conn = pool.getConnection();
			if (id.equals("admin")) {
				sql = "select count(*) from tblBasket";
				pstmt = conn.prepareStatement(sql);
			} else {

				sql = "select count(*) from tblBasket where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);

			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return totalCount;
	}

	/// 장바구니 삭제 시작 ///
	public void deleteBasket(int basketNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		try {
			conn = pool.getConnection();

			sql = "delete from tblBasket where basketNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, basketNum);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}

	}

	/// 구매 시작 ///
	public boolean purchaseBasket(int basketNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			conn = pool.getConnection();
			sql = "update tblBasket set buy=1 where basketNum=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, basketNum);

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return flag;
	}

	/// 구매 반환 시작 ///
	public BasketBean getPurchase(int basketNum) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BasketBean bean = new BasketBean();
		try {
			conn = pool.getConnection();
			sql = "select * from tblBasket where basketNum=? and buy=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, basketNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setId(rs.getString("id"));
				bean.setProductName(rs.getString("productName"));
				bean.setPrice(rs.getString("price"));
				bean.setProductNum(rs.getInt("productNum"));
				bean.setBasketNum(rs.getInt("basketNum"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setBuy(rs.getInt("buy"));
				bean.setBuydate(rs.getString("buydate"));
				bean.setProductType(rs.getString("productType"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return bean;
	}

	/// 구매 목록 반환 시작 ///
	public Vector<BasketBean> getPurchasetList(String id, int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BasketBean> vlist = new Vector<>();
		try {
			conn = pool.getConnection();
			if (id.equals("admin")) {
				sql = "select * from tblBasket where buy>0 order by baksetNum desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblBasket where id=? and buy>0";
				sql +=" order by basketNum desc limit ?, ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BasketBean bean = new BasketBean();
				bean.setId(rs.getString("id"));
				bean.setProductName(rs.getString("productName"));
				bean.setPrice(rs.getString("price"));
				bean.setProductNum(rs.getInt("productNum"));
				bean.setBasketNum(rs.getInt("basketNum"));
				bean.setQuantity(rs.getInt("quantity"));
				bean.setBuy(rs.getInt("buy"));
				bean.setBuydate(rs.getString("buydate"));
				bean.setProductType(rs.getString("productType"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return vlist;
	}

	/// 구매 목록 총 개수 반환 시작
	public int getTotalPurchase(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			conn = pool.getConnection();
			if (id.equals("admin")) {
				sql = "select count(*) from tblBasket where buy>0";
				pstmt = conn.prepareStatement(sql);
			} else {

				sql = "select count(*) from  tblProduct where id=? and buy>0";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);

			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt, rs);
		}
		return totalCount;
	}

	/// 구매 배송 처리 시작 /// 구매한 내역은 삭제하기보다 db에 남겨두는 게 좋을 것 같음.
	public boolean deliveryPurchase(int basketNum, int productNum, int quantity) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			conn = pool.getConnection();
			sql = "update tblBasket set buy=2 where basketNum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, basketNum);
			pstmt.executeUpdate();

			// 배송 처리하면 재고 변경도 같이 이뤄져야함
			sql = "update tblProduct set inventory=inventory-? where productNum=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, productNum);

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
		return flag;
	}
}
