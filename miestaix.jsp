<!DOCTYPE html>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%

	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "keliones";
	String userId = "root";
	String password = "";
	String[] lent_miestu = { "id_miesto", "pav", "gyv_sk", "plotas", "platuma", "ilguma", "valstybe"  };
	String[] lauk_miesto = new String [ lent_miestu.length ];		
%>
<html>
<%

	Connection connection = null;
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;

%>
	<head>
<%	
	String salis = "Lietuva";
	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}
	
	String id_miesto;
%>	
		<meta charset="utf-8">
		<style>
			table {
				border-collapse: collapse;
			}
			form {
				float: right;
			}
			input {
				width: 111px;
			}
			th, td {
				padding: 3px 4px;
				border: 1px solid black;
			}
			th {
				background-color: #A52A2A;
			}
			td {
				background-color: #DEB887;			
			}
		</style>
<%		
	try { 
	
		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		String add; 
	
		if ( ( ( add = request.getParameter("add")  ) != null ) && add.equals ( "papildyti" ) ) {
		
			for ( int i = 1; i<lent_miestu.length; i++ ) {
			
				lauk_miesto [ i ] = request.getParameter ( lent_miestu [ i ] );
			}
			String comma = "";
			id_miesto = request.getParameter( "id_miesto" );
		
			if  (  id_miesto.equals ( "0" ) ) {																																	// Miestai miestas = new Miestai ( lent_miestu );
																																					// miestas.takeFromParams ( request )
				String sql_ins = "";

				
				for ( int i = 1; i < lent_miestu.length - 1; i++ ) {
				
					sql_ins += comma  + "'" + lauk_miesto [ i ] + "'";
					comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
				}
				
				sql_ins = 
					"INSERT INTO `miestai`"
					+ " ( `pav`, `gyv_sk`, `plotas`, `platuma`, `ilguma` ) "
					+ " VALUES ( "			
					+ sql_ins
					+ " )";

				out.println ( sql_ins );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_ins);
				
			} else {
			
				String sql_upd = " UPDATE `miestai` SET\n";				
				
				for ( int i = 1; i < lent_miestu.length - 1; i++ ) {
				
					sql_upd += comma  + "`" + lent_miestu [ i ]  + "`='" + lauk_miesto [ i ] + "'\n";
					comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
				}
				sql_upd += "WHERE `id`=" + id_miesto;
				
				out.println ( sql_upd );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate( sql_upd );				
			}
		 } else {
		 
			if ( add != null ) {

				out.println ( add );
			}
		 }
		 
	}  catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>		 
		<script>

		
			function iRedagavima ( id_rec ) {
			
				if ( mygtukas = document.getElementById ( 'toEdit_' + id_rec ) ) {
<%
					for ( int i=1; i<lent_miestu.length; i++ ) {
%>					
																																					
						document.getElementById( '<%= lent_miestu [ i ]  %>' ).value =  mygtukas.dataset.<%= lent_miestu [ i ]  %>;
<%	
					}
%>
					document.getElementById ( "id_miesto" ).value = id_rec;
				}
			}
			
			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toEdit_' + id_rec );

				pav =  mygtukasEdit.dataset.pav;
				
				var r = confirm( "Ar norite pašalinti miestą " + pav + "?" );
				
				alert( r );
				alert ( r == true );
				
				if ( r == true ) {

					alert( id_rec + "1" );
					document.getElementById ( "m_del" ).value = id_rec;
					alert( id_rec  + "2" );
					forma_del = document.getElementById ( "del_rec" );
					alert( forma_del );
					forma_del.submit();
				}
			}
				alert ( "ops " );			
<%		
	try {
		String del;	
	
		if ( ( ( del = request.getParameter("del")  ) != null ) && del.equals ( "del1rec" ) ) {
%>
			alert( "opa" );
<%
			id_miesto = request.getParameter( "m_del" );
		
			String sql_fkey ="SELECT "
					+ " `id_miesto` "
				+ " FROM" 
					+ " `marsrutai_miestai` "  
				+ " WHERE "
					+ "`id_miesto` =" + id_miesto;
			Statement statement_check = connection.createStatement();					
			resultSet = statement_check.executeQuery(sql_fkey);
			
%>
			alert( "sql_fkey: <%= sql_fkey %>" );
<%			
			
			if ( resultSet.next() ) {
%>			
				alert ( "ups " );
<%				
			} else {
			
				String sql_delete ="DELETE"

						+ " FROM" 
							+ " `miestai`" ;
				sql_delete += " WHERE `id`=" + id_miesto;

				out.println ( sql_delete );

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_delete);
			}
			
		} /* else {
		 
			if ( del != null ) {

				out.println ( del );
			}
		 } */
		 
	}  catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>					
		</script>
	</head>
<body>
<h2 align="center"><strong>Retrieve data from database in jsp</strong></h2>
<form method="post" action="">
	<table>
		<tr>
			<th>Pavadinimas</th>
			<td>
				<input id="pav" type="text" name="pav" required>
			</td>
		</tr>
		<tr>
			<th>Gyv. sk.</th>
			<td>
				<input id="gyv_sk" type="number" name="gyv_sk" value="1">
			</td>
		</tr>
		<tr>
			<th>Plotas</th>
			<td>
				<input id="plotas" type="number" name="plotas" value="1">
			</td>
		</tr>
		<tr>
			<th>Platuma</th>
			<td>
				<input id="platuma" type="number" min="-90"  max="90" name="platuma" value="0">
			</td>
		</tr>
		<tr>
			<th>Ilguma</th>
			<td>
				<input id="ilguma" type="number" min="0" max="180" name="ilguma" value="0">
			</td>
		</tr>
		<tr>
			<th>Valst.</th>
			<td>			
				<input id="valstybe" type="text" name="valstybe">
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
				<input type="button" name="clear" value="valyti"> 
				<input type="submit" name="add" value="papildyti">
			</td>
		</tr>
	</table>
		<input type="hidden" id="id_miesto" name="id_miesto" value="0">
		<input type="hidden" id="alert" name="alert" value="0">
</form>
<form id="del_rec" method="post" action="">
	<input type="hidden" name="del" value="del1rec">
	<input type="hidden" id="m_del" name="m_del" value="0">
</form>
<table align="center">
<tr>
</tr>
<tr>
	<th>Funkcijos</th>
	<th>id</th>
	<th>Pavadinimas</th>
	<th>Gyv. sk.</th>
	<th>Plotas</th>
	<th>Platuma</th>
	<th>Ilguma</th>
	<th>Valst.</th>
</tr>
<%
	try {
	
		statement_take = connection.createStatement();		
		String sql ="SELECT"
					+ "`id`"
					+ ", `pav`" 
					+ ", `gyv_sk`"
					+ ", `plotas`"
					+ ", `platuma`"
					+ ", `ilguma`"
					+ ", '" + salis + "' AS `valstybe`"
				+ "FROM" 
					+ "`miestai`"  
				+ "WHERE"
					+ "1";

		//String sql ="SELECT * FROM `miestai`  WHERE 1";
		resultSet = statement_take.executeQuery(sql);
		

		 
		while( resultSet.next() ){
		
			String rec_data = "";
		
			for ( int i = 1; i < lauk_miesto.length; i++ ) {

				rec_data += " data-"  +lent_miestu [ i ]  + "=\"" + resultSet.getString (  lent_miestu [ i ]  ) + "\"";

			}
			String id_rec = resultSet.getString (  "id"  );
%>
<tr>
	<td><input type="button" class="record_edit"  id="toEdit_<%= id_rec  %>" data-id_miesto="<%= id_rec  %>"<%= rec_data %> value="&#9998;" onClick="iRedagavima( <%= id_rec %> )"></td>
	<td><input type="button" class="delete"  id="toDelete_<%= id_rec  %>" data-id_miesto="<%= id_rec %>" value="&#10007;" onClick="iTrinima( <%= id_rec %> )"></td>

<%
		for ( int i = 1; i < lauk_miesto.length; i++ ) {
%>
	<td><%= resultSet.getString (  lent_miestu [ i ]  ) %></td>
<%
		}
%>

</tr>
<% 
		}

	} catch ( Exception e ) {
	
		e.printStackTrace();
	}
%>
</table>
</body>