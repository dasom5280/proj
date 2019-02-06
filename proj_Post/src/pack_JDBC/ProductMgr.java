package pack_JDBC;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.mysql.cj.xdevapi.Result;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import pack_Bean.AccessRecordBean;
import pack_Bean.Ad_QnABean;
import pack_Bean.MemberBean;
import pack_Bean.ProductBean;
import pack_DBCP.DBConnectionMgr;
import pack_Util.UtilMgr;

public class ProductMgr {

	private DBConnectionMgr pool;
	// 각자 admin/img_Product의 경로를 찾아서 savafolder 값 변경을 해주어야함!
	private static final String SAVEFOLDER = "D:/javaEx/pradi/shop_proj/proj/proj_Post/WebContent/admin/img_Product";
	private static final String ENCTYPE = "utf-8";
	private static int MAXSIZE = 5 * 1024 * 1024;

	public ProductMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

////////////////////상품추가 시작 ////////////////////
	public boolean insertProduct(HttpServletRequest request) {

		Connection objConn = null;
		PreparedStatement objPstmt = null;
		String sql = null;
		boolean flag = false;

		// proc으로 보내줄때 form 속성 추가 필요!!
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;

		try {
			objConn = pool.getConnection();
			request.setCharacterEncoding("utf-8");

			File file = new File(SAVEFOLDER);
			if (!file.exists()) {
				file.mkdirs();
			}

			multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}

			sql = "insert into tblProduct " + " (productName, productType, explanation, price, inventory, "
					+ "sale, filename, filesize, salePercent) " + " values " + " (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			objPstmt = objConn.prepareStatement(sql);
			objPstmt.setString(1, multi.getParameter("productName"));
			objPstmt.setString(2, multi.getParameter("productType"));
			objPstmt.setString(3, multi.getParameter("explanation"));
			objPstmt.setString(4, multi.getParameter("price"));
			objPstmt.setString(5, multi.getParameter("inventory"));
			if (multi.getParameter("sale") != null) {
				int sale = Integer.parseInt(multi.getParameter("sale"));
				objPstmt.setInt(6, sale);
				
				int salePercent = Integer.parseInt(multi.getParameter("salePercent"));
				objPstmt.setInt(9, salePercent);
				
				// 후에 소비자 페이지에서 가격 표시할때 이거 참고
				//int price = Integer.parseInt(multi.getParameter("price"));
				//double salePrice = price * (1 - ((double) salePercent / 100));
				
			} else {
				objPstmt.setInt(6, 0);
				objPstmt.setInt(9, 0);
			}
			objPstmt.setString(7, filename);
			objPstmt.setInt(8, filesize);
			
			

			if (objPstmt.executeUpdate() == 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objPstmt);
		}

		return flag;

	}
////////////////////상품추가 끝 ////////////////////

////////////////////상품수정 시작 ////////////////////
	public boolean updateProduct(HttpServletRequest request) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblProduct set productName=?, productType=?, explanation=?, price=?, inventory=?, sale=?, salePercent=?"
					+ " where productNum=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, request.getParameter("productName"));
			pstmt.setString(2, request.getParameter("productType"));
			pstmt.setString(3, request.getParameter("explanation"));
			pstmt.setString(4, request.getParameter("price"));
			pstmt.setString(5, request.getParameter("inventory"));
			
			if(request.getParameter("sale")!=null) {
			pstmt.setInt(6, 1);
			pstmt.setInt(7, Integer.parseInt(request.getParameter("salePercent")));
			} else {
			pstmt.setInt(6, 0); 
			pstmt.setInt(7, 0);
			}
			int a = Integer.parseInt(request.getParameter("productNum"));
			pstmt.setInt(8, a);

			if (pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
////////////////////상품수정 끝 ////////////////////

////////////////////상품 삭제 시작 ////////////////////
	public void deleteProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select filename from tblProduct where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getString(1) != null) {
				if (!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER + "/" + rs.getString(1));
					if (file.exists()) {
						UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
					}
				}
			}
			
			sql = "delete from tblProduct where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			pstmt.executeUpdate();

// foreign key 설정된 모든 자료를 지워야 함

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}

	}
////////////////////상품 삭제 끝 ////////////////////

////////////////////상품 목록 반환 ////////////////////
	public Vector<ProductBean> getProductList() {

		Connection objConn = null;
		Statement objStmt = null;
		ResultSet objRs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<>();

		try {

			objConn = pool.getConnection();
			sql = "select * from tblProduct";
			objStmt = objConn.createStatement();
			objRs = objStmt.executeQuery(sql);

			while (objRs.next()) {
				ProductBean bean = new ProductBean();
				bean.setProductNum(objRs.getInt("productNum"));
				bean.setProductName(objRs.getString("productName"));
				bean.setProductType(objRs.getString("productType"));
				bean.setExplanation(objRs.getString("explanation"));
				bean.setPrice(objRs.getString("price"));
				bean.setInventory(objRs.getString("inventory"));
				bean.setSale(objRs.getInt("sale"));
				bean.setSalePercent(objRs.getInt("salePercent"));
				vlist.add(bean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(objConn, objStmt, objRs);
		}
		return vlist;
	}

////////////////////상품 목록 반환 끝 ////////////////////

	// 게시판 리스트
	public Vector<ProductBean> getProductList(String keyField, String keyWord, int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from tblProduct order by productNum desc limit ?, ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from  tblProduct where " + keyField + " like ? ";
				sql += " order by productNum desc limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setProductNum(rs.getInt("productNum"));
				bean.setProductName(rs.getString("productName"));
				bean.setProductType(rs.getString("productType"));
				bean.setExplanation(rs.getString("explanation"));
				bean.setPrice(rs.getString("price"));
				bean.setInventory(rs.getString("inventory"));
				bean.setSale(rs.getInt("sale"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setSalePercent(rs.getInt("salePercent"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	// 총 게시물수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(*) from tblProduct";
				pstmt = con.prepareStatement(sql);
			} else {

				sql = "select count(*) from  tblProduct where " + keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");

			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

////////////////////상품 정보 반환 시작 ////////////////////
	public ProductBean getProduct(int productNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblProduct where productNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, productNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setProductNum(rs.getInt("productNum"));
				bean.setProductName(rs.getString("productName"));
				bean.setProductType(rs.getString("productType"));
				bean.setExplanation(rs.getString("explanation"));
				bean.setPrice(rs.getString("price"));
				bean.setInventory(rs.getString("inventory"));
				bean.setSale(rs.getInt("sale"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setSalePercent(rs.getInt("salePercent"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
////////////////////상품 정보 반환 끝 ////////////////////

/////상품 이미지 다운로드//////

	public void downLoad(HttpServletRequest req, HttpServletResponse res, JspWriter out, PageContext pageContext) {

		try {
			String filename = req.getParameter("filename");
			File file = new File(UtilMgr.con(SAVEFOLDER + File.separator + filename));

			byte[] b = new byte[(int) file.length()];

			res.setHeader("Accept-Ranger", "bytes");
			String strClient = req.getHeader("User-Agent");
			if (strClient.indexOf("MSIE6.0") != -1) {
				res.setContentType("application/smnet;charset=utf-8");
				res.setHeader("Content-Disposition", "filename=" + filename + ";");
			} else {
				res.setContentType("application/smnet;charset=utf=8");
				res.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
			}

			out.clear();
			out = pageContext.pushBody();
			if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(res.getOutputStream());
				int read = 0;
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}

				outs.close();
				fin.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
