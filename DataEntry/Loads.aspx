<%@ Page Title="الحمولات المدخلة" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void ImageButton2_Command(object sender, CommandEventArgs e)
    {
        if (DataBase.Delete("Transports", "id", e.CommandArgument.ToString()))
        {
            DataBase.Delete("transcapon", "transid", e.CommandArgument.ToString());
            Message msg = new Message("تم حذف الحمولة", true, "Loads.aspx", "Loads.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
        else
        {
            Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "Loads.aspx", "Loads.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        Session["PID"] = e.CommandArgument.ToString();
        if (e.CommandName.Equals("Edit"))
        {
            Session["PID2"] = "1";
            Response.Redirect("LoadsEdit.aspx");
        }
        else if (e.CommandName.Equals("Edit2"))
        {
            Session["PID2"] = "2";
            Response.Redirect("LoadsEdit.aspx");
        }
        else
        {
            
        }
        
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            
            
            Label l = (Label)e.Row.FindControl("no");

            
            System.Data.DataTable dt = DataBase.GetData("transcapon", new string[] {"transid" }, new string[] {l.Text });
            string str1 = "رقم الكابون        نوع الكابون" ;
            string str2 = "";
            for (int i = 0; i < dt.Rows.Count;i++ )
            {
                str2 += dt.Rows[i]["type"].ToString() + "\\t\\t" + dt.Rows[i]["no"].ToString()+"\\n";
            }
            LinkButton capon = (LinkButton)e.Row.FindControl("CaponLink");
            capon.OnClientClick = "alert('"+str1+"\\n"+str2+"');return false;";
            
            
            l.Text = (int.Parse(l.Text) - 32).ToString();

            HiddenField h = (HiddenField)e.Row.FindControl("EnterUser");
            /*ImageButton ib = (ImageButton)e.Row.FindControl("ImageButton2");
            if (h.Value.Equals(Session["id"].ToString()))
            {

                ib.Visible = true;
            }
            else
            {
                ib.Visible = false;
            }*/



            ImageButton ib = (ImageButton)e.Row.FindControl("ImageButton1");

            ib.Visible = false;
            if (h.Value.Equals(Session["id"].ToString()))
            {
                ib.CommandName = "Edit";
                ib.Visible = true;
            }

            h = (HiddenField)e.Row.FindControl("UpdateUser");
            if (h.Value.Equals(Session["id"].ToString()))
            {
                ib.CommandName = "Edit2";
                ib.Visible = true;
            }
        }
    }

    protected void idSearch_TextChanged(object sender, EventArgs e)
    {
        
        int tmp;
        if (int.TryParse(idSearch.Text, out tmp))
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where Transports.id=" + (tmp+32) + " Order By id";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
        else
        {
            if (idSearch.Text.Length == 0)
            {
                SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
                SqlDataSource1.DataBind();
                GridView1.DataBind();
            }
        }
        
    }

    protected void DriverSearch_TextChanged(object sender, EventArgs e)
    {
        if (DriverSearch.Text.Length != 0)
        {


            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where Drivers.name like '" + DriverSearch.Text + "%' Order By Drivers.name";
            SqlDataSource1.DataBind();
            GridView1.DataBind();

        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void LeavingTimeSearch_TextChanged(object sender, EventArgs e)
    {
        DateTime tmp;
        if (LeavingTimeSearch.Text.Length != 0)
        {
            if (DateTime.TryParse(LeavingTimeSearch.Text, out tmp))
            {
                SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where year(Transports.LeavingTime1)=" + tmp.Year + " and month(Transports.LeavingTime1)=" + tmp.Month + " and day(Transports.LeavingTime1)="+tmp.Day+" Order By LeavingTime1";
                SqlDataSource1.DataBind();
                GridView1.DataBind();
            }
            else
            {
                LeavingTimeSearch.Text = "خطا في التاريخ";
            }
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void CarSearch_TextChanged(object sender, EventArgs e)
    {
        if (CarSearch.Text.Length != 0)
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where Cars.Number='"+CarSearch.Text+"' Order By Cars.Number";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void TrailerSearch_TextChanged(object sender, EventArgs e)
    {
        if (TrailerSearch.Text.Length != 0)
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where Trailer.Number='" + TrailerSearch.Text + "' Order By Trailer.Number";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void ArrivalTimeSearch_TextChanged(object sender, EventArgs e)
    {
        if (ArrivalTimeSearch.Text.Length != 0)
        {
            DateTime tmp;
            if(DateTime.TryParse(ArrivalTimeSearch.Text,out tmp))
            {
                SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where year(Transports.ArrivalTime1)="+tmp.Year+" and month(Transports.ArrivalTime1)="+tmp.Month+" and day(Transports.ArrivalTime1)="+tmp.Day+" Order By ArrivalTime1";
                SqlDataSource1.DataBind();
                GridView1.DataBind();
            }
            else
            {
                ArrivalTimeSearch.Text="خطا في التاريخ";    
            }
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void NotArrivalLINK_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where arrivaltime1 is null Order By LeavingTime1";
        SqlDataSource1.DataBind();
        GridView1.DataBind();
    }

    protected void ShowAll_Click(object sender, EventArgs e)
    {
        SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
        SqlDataSource1.DataBind();
        GridView1.DataBind();
    }

    protected void LoadNoSearch_TextChanged(object sender, EventArgs e)
    {
        if (LoadNoSearch.Text.Length != 0)
        {

            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where (Transports.LoadNo Like '"+LoadNoSearch.Text+"%') Order By LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
            
        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }

    protected void EmptyingNoSearch_TextChanged(object sender, EventArgs e)
    {
        if (EmptyingNoSearch.Text.Length != 0)
        {

            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where (Transports.EmptyingNo Like '" + EmptyingNoSearch.Text + "%') Order By LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();

        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    }
    
    protected void DocNoSearch_TextChanged(object sender, EventArgs e)
    {
        if (DocNoSearch.Text.Length != 0)
        {

            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id Where (Transports.DocNo = " + DocNoSearch.Text + ") Order By LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();

        }
        else
        {
            SqlDataSource1.SelectCommand = "SELECT Transports.ArrivalTime,Transports.DocNo, Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1";
            SqlDataSource1.DataBind();
            GridView1.DataBind();
        }
    } 

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    month1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    
                }
                day1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                
            }

            if (day1.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day1.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month1.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month1.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year1.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year1.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }

            SqlDataSource1.SelectParameters["year"].DefaultValue = year1.SelectedValue;
            SqlDataSource1.SelectParameters["month"].DefaultValue = month1.SelectedValue;
            SqlDataSource1.SelectParameters["day"].DefaultValue = day1.SelectedValue;
            SqlDataSource1.DataBind();
            GridView1.DataBind();
            
        }
    }

    protected void datechage_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["year"].DefaultValue = year1.SelectedValue;
        SqlDataSource1.SelectParameters["month"].DefaultValue = month1.SelectedValue;
        SqlDataSource1.SelectParameters["day"].DefaultValue = day1.SelectedValue;
        SqlDataSource1.DataBind();
        GridView1.DataBind();
    }

    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager EnablePartialRendering="true"  ID="ScriptManager1" runat="server" >
        
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers>
        <asp:PostBackTrigger ControlID="GridView1" />
    </Triggers>
    <ContentTemplate>
    
   
    
    
    
    <table width="100%" align="center" class="DataEnterTable">
        <tr>
            <td class="Title">
               الحمولات المدخلة بتاريخ 
               <asp:DropDownList AutoPostBack="true" ID="day1" runat="server" OnSelectedIndexChanged="datechage_SelectedIndexChanged">
               </asp:DropDownList> - 
               <asp:DropDownList AutoPostBack="true" ID="month1" runat="server" OnSelectedIndexChanged="datechage_SelectedIndexChanged">
               </asp:DropDownList> - 
               <asp:DropDownList AutoPostBack="true" ID="year1" runat="server" OnSelectedIndexChanged="datechage_SelectedIndexChanged">
               </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT Drivers.Name, Cars.Number AS Cars_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name,Transports.ID,Transports.ArrivalTime, Transports.Tonnage, Transports.Tonnage2, Transports.LoadNo, Transports.EmptyingNo,Transports.DocNo, Transports.LeavingTime1, Transports.ArrivalTime1, Transports.EnterUserId1, Transports.UpdateUserId1, Transports.EnterTime1, Transports.UpdateTime1 FROM Centers INNER JOIN Cars INNER JOIN Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id ON Cars.id = Transports.CarID INNER JOIN Trailer ON Transports.TrailerID = Trailer.id ON Centers.id = Transports.FromId INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id where year(Transports.LeavingTime1)=@year and month(Transports.LeavingTime1)=@month and day(Transports.LeavingTime1)=@day Order By Transports.LeavingTime1">
                <SelectParameters>
                    <asp:Parameter Name="year" />
                    <asp:Parameter Name="month" />
                    <asp:Parameter Name="day" />
                </SelectParameters>
                </asp:SqlDataSource>
                
                <br />
                <a href="AddNewLoad.aspx">أضافة حمولة جديدة</a>
                <br /><br />
                
                
                <table class="LogInTable">
                    
                    <thead>
                        <tr>
                            <td colspan="8">
                                بحث عن حمولة
                            </td>
                        </tr>
                    </thead>
                    <tr>
                        <td>
                            رقم الحمولة
                        </td>
                        <td>
                            <asp:TextBox Width="50" ID="idSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="idSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            اسم السائق
                        </td>
                        <td>
                            <asp:TextBox Width="100" ID="DriverSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="DriverSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            تاريخ التحميل
                        </td>
                        <td>
                            <asp:TextBox Width="100" ID="LeavingTimeSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="LeavingTimeSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            رقم القاطرة
                        </td>
                        <td>
                            <asp:TextBox Width="60" ID="CarSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="CarSearch_TextChanged"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td>
                            رقم المقطورة
                        </td>
                        <td>
                            <asp:TextBox Width="60" ID="TrailerSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="TrailerSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            تاريخ التفريغ
                        </td>
                        <td>
                            <asp:TextBox Width="100" ID="ArrivalTimeSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="ArrivalTimeSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            رقم التحميل
                        </td>
                        <td>
                            <asp:TextBox Width="50" ID="LoadNoSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="LoadNoSearch_TextChanged"></asp:TextBox>
                        </td>
                        <td>
                            رقم التفريغ
                        </td>
                        <td>
                            <asp:TextBox Width="50" ID="EmptyingNoSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="EmptyingNoSearch_TextChanged"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td>رقم الوصل</td>
			<td><asp:TextBox Width="50" ID="DocNoSearch" CssClass="Text" runat="server" AutoPostBack="True" OnTextChanged="DocNoSearch_TextChanged"></asp:TextBox></td>
			<td colspan="2">
                            <asp:LinkButton ID="NotArrivalLINK" runat="server" OnClick="NotArrivalLINK_Click">عرض الحمولات التي لم تصل</asp:LinkButton> 
                        </td>
                        <td colspan="4">
                            <asp:LinkButton ID="ShowAll" runat="server" OnClick="ShowAll_Click">عرض كل الحمولات</asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:GridView DataSourceID="SqlDataSource1" ID="GridView1" runat="server" 
                    AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" 
                    GridLines="Both"  Width="1200" OnRowDataBound="GridView1_RowDataBound" AllowPaging="true" PageSize="40" AllowSorting="true">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="no" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Name" HeaderText="اسم السائق" SortExpression="Name" />
                        <asp:BoundField DataField="Cars_Number" HeaderText="القاطرة" 
                            SortExpression="Cars_Number" />
                        <asp:BoundField DataField="Trailer_Number" HeaderText="المقطورة" 
                            SortExpression="Trailer_Number" />
                        <asp:BoundField DataField="From_Name" HeaderText="من" 
                            SortExpression="From_Name" />
                        <asp:BoundField DataField="To_Name" HeaderText="الى" 
                            SortExpression="To_Name" />
                        <asp:BoundField DataField="Tonnage" HeaderText="الحمولة" 
                            SortExpression="Tonnage" DataFormatString="{0:###,###,###}" />
                        <asp:BoundField DataField="Tonnage2" HeaderText="التفريغ" 
                            SortExpression="Tonnage2" DataFormatString="{0:###,###,###}" />
                        <asp:BoundField DataField="LoadNo" HeaderText="رقم التحميل" 
                            SortExpression="LoadNo" />
                        <asp:BoundField DataField="EmptyingNo" HeaderText="رقم التفريغ" 
                            SortExpression="EmptyingNo" />
			<asp:BoundField DataField="DocNo" HeaderText="رقم الوصل" 
                            SortExpression="DocNo" />
                        <asp:BoundField DataField="LeavingTime1" HeaderText="المغادرة" 
                            SortExpression="LeavingTime1" DataFormatString="{0:dd/MM/yyyy&nbsp;&nbsp;HH:mm}" />
                        <asp:BoundField DataField="ArrivalTime" HeaderText="الوصول" 
                            SortExpression="ArrivalTime" DataFormatString="{0:dd/MM/yyyy&nbsp;&nbsp;HH:mm}" />
                        <asp:BoundField DataField="ArrivalTime1" HeaderText="الانتهاء" 
                            SortExpression="ArrivalTime1" DataFormatString="{0:dd/MM/yyyy&nbsp;&nbsp;HH:mm}" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="CaponLink"  runat="server" >الكابونات</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Edit.png" Width="25" Height="20" ID="ImageButton1" runat="server" OnCommand="ImageButton1_Command" />
                        </ItemTemplate>
                    </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton Visible="false" CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Delete.png" Width="25" Height="20" OnClientClick="return confirm('هل متاكد من حذف الحمولة');" ID="ImageButton2" runat="server" OnCommand="ImageButton2_Command" />
                        <asp:HiddenField ID="EnterUser" Value='<%#Eval("EnterUserId1") %>' runat="server" />
                        <asp:HiddenField ID="UpdateUser" Value='<%#Eval("UpdateUserId1") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>    
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="Title">
                            لا يوجد بيانات
                        </div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
            </td>
        </tr>
    </table>
    
    </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

