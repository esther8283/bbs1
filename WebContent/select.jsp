<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택한 글 확인</title>
<style>
	table {
		width:100%;
		border:1px soild black;
		border-collapse:collapse;
	}
	td, th {
		border:1px solid black;
	}
	.container {
		width:960px;
		margin:0px auto;
	}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String number = request.getParameter("num");
		int num = Integer.parseInt(number);
		/* 주소창에 http://localhost:8080/bbs1/select.jsp?num=글번호 입력 */
	%>
	<%@ include file="dbConn.jsp" %>
	<!-- select 문을 사용하여 지정한 1개의 글의 내용을 가져오기 -->
	<%
		ResultSet rs = null;
		/* PreparedStatement psmt = null; */
		Statement stmt = null;
		
		try {
			/* 끝에 무조건 한칸 띄우기! 아님 오류남(띄우지 않으면 다음 글과 이어붙여진것처럼 읽힘)  */
			String query = "SELECT title, comments, writer, cdate, ";
			query += "views, likes ";
			query += "FROM bbs ";
			query += "WHERE num =  " + num;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			rs.next();
			String title = rs.getString("title");
			String comments = rs.getString("comments");
			String writer = rs.getString("writer");
			String cdate = rs.getString("cdate");
			String views = rs.getString("views");
			String likes = rs.getString("likes");
			
			/* while(rs.next()) {
				String title = rs.getString("title");
				String comments = rs.getString("comments");
				String writer = rs.getString("writer");
				String cdate = rs.getString("cdate");
				String views = rs.getString("views");
				String likes = rs.getString("likes");
				
				out.println(title + "<br>");
				out.println(comments + "<br>");
				out.println(writer + "<br>");
				out.println(cdate + "<br>");
				out.println(views + "<br>");
				out.println(likes + "<br>");
			} */
	%>
		<div class="container">
			<table>
				<thead>
					<tr>
						<th colspan=3><%= rs.getString("title") %></th>
					</tr>
				</thead>
				<tbody>
				<tr>
					<td><%= rs.getString("writer") %></td>
					<td><%= rs.getString("views") %></td>
					<td><%= rs.getString("likes") %></td>
				</tr>
				<tr>
					<td colspan=3><%= rs.getString("comments") %></td>
				</tr>
				</tbody>
			</table>
		</div>
		<a href="./lists.jsp">목록으로</a>
		<a href="./modify.jsp?num=<%= num %>">수정하기</a>
	<% 
		}
		catch (SQLException ex) {
			out.println("글 조회를 실패했습니다.");
			out.println("SQLException : " + ex.getMessage());
		}
		finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
			if(conn != null) {
				conn.close();
			}
		}
	%>
</body>
</html>