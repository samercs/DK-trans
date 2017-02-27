using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
/// <summary>
/// Summary description for DataBase
/// </summary>
public class DataBase
{
    public static DataTable GetData(string TableName, string[] Param, string[] ParamValue)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        string sql = "Select * from " + TableName + " where ";
        for (int i = 0; i < Param.Length; i++)
        {
            if(i==0)
                sql += Param[i] + "=@" + Param[i];
            else
                sql += " and " + Param[i] + "=@" + Param[i] ;

            cmd.Parameters.AddWithValue("@" + Param[i], ParamValue[i]);
        }

        cmd.CommandText = sql;

        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }

        SqlDataAdapter r = new SqlDataAdapter(cmd);
        
        DataTable dt=new DataTable();
        r.Fill(dt);


        


        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }

        return dt;

    }


    public static DataTable EXESQL(string sql)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand(sql,con);
        

        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }


        SqlDataAdapter da = new SqlDataAdapter(cmd);
        System.Data.DataTable dt = new DataTable();
        da.Fill(dt);



        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }

        return dt;

    }


    public static object GetMax(string TableName,string ColName)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select max("+ColName+") as s from "+TableName, con);


        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }


        object result = cmd.ExecuteScalar();



        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }

        return result;

    }

    public static object GetCount(string TableName)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand("select count(*) as s from " + TableName, con);


        if (con.State == ConnectionState.Closed)
        {
            con.Open();
        }


        object result = cmd.ExecuteScalar();



        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }

        return result;

    }

    public static string ChangePassword(string id, string CurrentPassword, string NewPassword)
    {
        string result = "done";

        string TrueCurrentPassword = GetPName("users", "password", "id", id);
        if (TrueCurrentPassword.Equals(CurrentPassword))
        {
            DataBase.UpdateData("users", new string[] { "password" }, new string[] { NewPassword }, "id", id);
        }
        else
        {
            result = "كلمة السر الحالية خطأ";
        }

        return result;
    }

    public static bool Insert(string TableName, string[] Param, string[] ParamValue)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        string sql = "Insert Into "+TableName+" (";
        for (int i = 0; i < Param.Length; i++)
        {
            if (i == 0)
                sql += Param[i];
            else
                sql += "," + Param[i];
        }
        sql += ") values(";
        for (int i = 0; i < Param.Length; i++)
        {
            if (i == 0)
                sql += "@"+Param[i];
            else
                sql += " , @" + Param[i];
            cmd.Parameters.AddWithValue("@" + Param[i], ParamValue[i]);
        }
        sql += ")";

        bool result = true;
        
        try
        {
            con.Open();
            cmd.CommandText = sql;
            cmd.ExecuteNonQuery();
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = false;
            }
        }

        return result;
    }

    public static string GetPName(string tablename,string poname , string pname, string pvalue)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select " + poname + " from " + tablename + " where " + pname + "=@" + pname;
        cmd.Parameters.AddWithValue("@" + pname, pvalue);
        string result="";
        try
        {
            con.Open();
            SqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                result = r[poname].ToString();
            }
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = "";
            }
        }

        return result;
    }

    public static bool UpdateData(string tablename, string[] changeparameter, string[] newvalue, string pname, string pvalue)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        string sql = "Update " + tablename + " Set ";
        for (int i = 0; i < changeparameter.Length; i++)
        {
            if (i == 0)
                sql += changeparameter[i]+"=@"+changeparameter[i];
            else
                sql += "," + changeparameter[i] + "=@" + changeparameter[i];

            cmd.Parameters.AddWithValue("@" + changeparameter[i], newvalue[i]);
        }

        sql += " where " + pname + "=@" + pname;
        cmd.Parameters.AddWithValue("@" + pname, pvalue);

        bool result = true;

        try
        {
            con.Open();
            cmd.CommandText = sql;
            cmd.ExecuteNonQuery();
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = false;
            }
        }

        return result;
    }

    public static bool Delete(string TableName, string id, string idvalue)
    {
        bool result = true;
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand("delete from "+TableName+" where "+id+"=@id",con);
        cmd.Parameters.AddWithValue("@id", idvalue);
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = false;
            }
        }

        return result;

    }

    public static string Get330capon(string id)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select no from transCapon where type=330 and transid=@id" ;
        cmd.Parameters.AddWithValue("@id", id);
        string result = "";
        try
        {
            con.Open();
            SqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                result = r["no"].ToString();
            }
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = "";
            }
        }

        return result;
    }

    public static string Get50capon(string id)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select no from transCapon where type=50 and transid=@id";
        cmd.Parameters.AddWithValue("@id", id);
        string result = "";
        try
        {
            con.Open();
            SqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                result = r["no"].ToString();
            }
            con.Close();
        }

        catch
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                result = "";
            }
        }

        return result;
    }

    public static string[] getTrailerMoveCount(string id,DateTime d1,DateTime d2)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select count(*) as c,sum(tonnage) as t from transports where trailerid=@id and (DATEDIFF(mi,LeavingTime1,@d1)<=0 and DATEDIFF(mi,LeavingTime1,@d2)>=0)";
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@d1", d1);
        cmd.Parameters.AddWithValue("@d2", d2);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        string[] result = new string[2];
        result[0] = "0";
        result[1] = "0";
        if (r.Read())
        {
            if (r["c"] != DBNull.Value)
            {
                result[0] = r["c"].ToString();
            }
            if (r["t"] != DBNull.Value)
            {
                result[1] = r["t"].ToString();
            }
        }
        con.Close();
        return result;

    }

    public static string getTrailerMoveCount(string id, DateTime d1)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select count(*) as c from transports where trailerid=@id and (year(LeavingTime1)=@year and month(LeavingTime1)=@month and day(LeavingTime1)=@date)";
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@year", d1.Year);
        cmd.Parameters.AddWithValue("@month", d1.Month);
        cmd.Parameters.AddWithValue("@date", d1.Day);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        string result ="0";
        
        if (r.Read())
        {
            if (r["c"] != DBNull.Value)
            {
                result = r["c"].ToString();
            }
            
        }
        con.Close();
        return result;

    }

    public static string getTrailerMoveAmount(string id, DateTime d1)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select sum(tonnage) as c from transports where trailerid=@id and (year(LeavingTime1)=@year and month(LeavingTime1)=@month and day(LeavingTime1)=@date)";
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@year", d1.Year);
        cmd.Parameters.AddWithValue("@month", d1.Month);
        cmd.Parameters.AddWithValue("@date", d1.Day);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        string result = "0";

        if (r.Read())
        {
            if (r["c"] != DBNull.Value)
            {
                result = r["c"].ToString();
            }

        }
        con.Close();
        return result;

    }

    public static string getCarMoveCount(string id, DateTime d1)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "select count(*) as c from transports where Carid=@id and (year(LeavingTime1)=@year and month(LeavingTime1)=@month and day(LeavingTime1)=@date)";
        cmd.Parameters.AddWithValue("@id", id);
        cmd.Parameters.AddWithValue("@year", d1.Year);
        cmd.Parameters.AddWithValue("@month", d1.Month);
        cmd.Parameters.AddWithValue("@date", d1.Day);
        SqlDataReader r;
        con.Open();
        r = cmd.ExecuteReader();
        string result = "0";

        if (r.Read())
        {
            if (r["c"] != DBNull.Value)
            {
                result = r["c"].ToString();
            }

        }
        con.Close();
        return result;

    }


    public const string Transports = "Transports";
    public const string ID = "ID";
    public const string DriverId = "DriverID";
    public const string CarID = "CarId";
    public const string TrailerID = "TrailerID";
    public const string FromID = "FromID";
    public const string ToID = "ToID";
    public const string Tonnage = "Tonnage";
    public const string Tonnage2 = "Tonnage2";
    public const string LoadNo = "LoadNo";
    public const string EmptyingNo = "EmptyingNo";
    public const string LeavingTime1 = "LeavingTime1";
    public const string ArrivalTime1 = "ArrivalTime1";
    public const string EnterUserId1 = "EnterUserId1";
    public const string EnterUserId2 = "EnterUserId2";
    public const string UpdateUserId1 = "UpdateUserId1";
    public const string EnterTime1 = "EnterTime1";
    public const string UpdateTime1 = "UpdateTime1";
    





 


}
