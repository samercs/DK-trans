<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["id"] != null)
        {
            if (Application["User" + Session["id"].ToString()] != null)
            {
                Application["User" + Session["id"].ToString()] = "false";
            }
        }
        Session.Clear();
        HttpCookie c = new HttpCookie("Data2");
        c.Expires = DateTime.Now.AddDays(-1);
        Response.Cookies.Add(c);
        Response.Redirect("../Default.aspx");
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
