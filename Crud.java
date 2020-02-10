
	package classx;

	public class Crud {
		
		public String lent;
		public String[] laukai;
		public String[] n_pav;
		public String sal;
		public String comma;
		// public Connection conn;
		
		public Crud() {
		}
		
		public Crud ( String lentele, String[] laukeliai ) {
			
			lent = lentele;
			laukai = laukeliai;
		}
		
		public String delete(String id_trinamo) {
			
			String sql_delete ="DELETE"

						+ " FROM" 
							+ " `" + lent + "` " ;
				sql_delete += " WHERE `id`=" + id_trinamo;

			return sql_delete;
		}
		public String select() {
			
			comma = "";
			String sql_sel = "SELECT ";
								
			for (int i = 0; i < laukai.length; i++){
				
				sql_sel += comma + " `" + laukai[i] + "` ";
				comma = ",";
			}
			sql_sel += " FROM" 
				+ " `" + lent + "` "  
			+ " WHERE "
				+ "1";
			
			return sql_sel;
		}
		
		public String select(String salyga) {
			
			sal = salyga;
			comma = "";
			String sql_sel1 ="SELECT ";
			
			for (int i = 0; i < laukai.length; i++){
				
				sql_sel1 += comma + " `" + laukai[i] + "` ";
				comma = ",";
			}
			sql_sel1 += " FROM" 
				+ " `" + lent + "` "  
			
			+ " WHERE "
				+ sal;
				
			return sql_sel1;
		}
		
		public String select(String[] nauji_pav) {
			
			n_pav = nauji_pav;
			comma = "";
			String sql_sel2 ="SELECT ";
			
				for (int i = 0; i < laukai.length; i++){
					
					sql_sel2 += comma + " `" + laukai[i] + "` AS `" + n_pav[i] + "` ";
					comma = ",";
				}
				sql_sel2 += " FROM" 
						+ " `" + lent + "` "  
					+ " WHERE "
						+ "1";
			return sql_sel2;
		}
		
		public String select(String[] nauji_pav, String salyga) {
			
			n_pav = nauji_pav;
			sal = salyga;
			comma = "";
			String sql_sel3 = "SELECT ";
									
				for (int i = 0; i < laukai.length; i++){
					
					sql_sel3 += comma  + " `" + laukai [ i ] + "` AS `" + n_pav[i] + "` ";
					comma = ",";
					
				}
		
			sql_sel3 += " FROM" 
					+ " `" + lent + "` "  
				+ " WHERE "
					+ sal;
			return sql_sel3;
		}
		
		public String insert(String[] values) {
			
			String[] reiksmes = values;
			String sql_insert = "INSERT INTO " + " `" + lent + "` ( ";
			String comma = "";
			
			for ( int i = 1; i < laukai.length; i++ ) {
				
				sql_insert += comma  + " `" + laukai [ i ] + "` ";
				comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
			}
			
			comma = "";
			sql_insert += ") VALUES ( ";
			for ( int i = 1; i < reiksmes.length; i++ ) {

				sql_insert += comma + " '" + reiksmes[i] + "' ";
				comma = ",";	
				
			}
			sql_insert += " )";

			return sql_insert;
		}
		
		public String update(String[]values, String salyga) {
			
			String[]reiksmes = values;
			sal = salyga;
			String sql_update = "UPDATE" + " `" + lent + "` SET\n ";
			String comma = "";
			
			for ( int i = 0; i < laukai.length; i++ ) {
				
				sql_update += comma  + " `" + laukai [ i ] + "`='" + reiksmes [ i ] + "'\n";
				comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
			}
			
			sql_update += "WHERE " + sal;
			
			return sql_update;
		}
		
	}