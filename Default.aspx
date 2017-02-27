<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    private void setSessionValues(System.Data.DataTable dt)
    {
        Session["Name"] = dt.Rows[0]["name"].ToString();
        Session["UserName"] = dt.Rows[0]["username"].ToString();
        Session["id"] = dt.Rows[0]["id"].ToString();
        Session["type"] = dt.Rows[0]["type"].ToString();
        Application.Lock();
        Application["User" + dt.Rows[0]["id"].ToString()] = "true";
        Application.UnLock();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {


        System.Data.DataTable dt = DataBase.GetData("Users", new string[] { "username", "password" }, new string[] { TextBox1.Text, TextBox2.Text });
        if (dt.Rows.Count > 0)
        {
            if (cbRememberMe.Checked)
            {
                HttpCookie c = new HttpCookie("Data");
                c.Values.Add("username", TextBox1.Text);
                c.Values.Add("password", TextBox2.Text);
                c.Expires = DateTime.Now.AddYears(1);
                Response.Cookies.Add(c);
            }
            else
            {
                HttpCookie c = new HttpCookie("Data");
                c.Values.Add("username", TextBox1.Text);
                c.Values.Add("password", TextBox2.Text);
                c.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c);
            }

            if (cbKeepMeLogin.Checked)
            {
                HttpCookie c2 = new HttpCookie("Data2");
                c2.Values.Add("id", dt.Rows[0]["id"].ToString());
                c2.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(c2);
            }
            else
            {
                HttpCookie c2 = new HttpCookie("Data2");
                c2.Values.Add("id", dt.Rows[0]["name"].ToString());
                c2.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(c2);
            }

            setSessionValues(dt);
            if (dt.Rows[0]["type"].ToString().Equals("1"))
            {
                Response.Redirect("Admin/Default.aspx");
            }
            else if (dt.Rows[0]["type"].ToString().Equals("4"))
            {
                Response.Redirect("Karaj/Default.aspx");
            }
            else
            {
                Response.Redirect("DataEntry/Default.aspx");
            }
        }
        else
        {
            Label1.Text = "Error UserName Or Password";
            Label1.Visible = true;
            Image1.Visible = true;
        }

    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Message msg = new Message("الرجاء الاتصال على مدير النظام للحصول على كلمة السر", true, "Default.aspx", "Default.aspx");
        Session["MSG"] = msg;
        Response.Redirect("Message.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            cbKeepMeLogin.Checked = true;
            if (Request.Cookies["Data2"] != null)
            {
                HttpCookie c2 = Request.Cookies["Data2"];
                System.Data.DataTable dt = DataBase.GetData("Users", new string[] { "id" }, new string[] { c2.Values["id"] });
                if (dt.Rows.Count > 0)
                {
                    setSessionValues(dt);
                    if (dt.Rows[0]["type"].ToString().Equals("1"))
                    {
                        Response.Redirect("Admin/Default.aspx");
                    }
                    else if (dt.Rows[0]["type"].ToString().Equals("4"))
                    {
                        Response.Redirect("Karaj/Default.aspx");
                    }
                    else
                    {
                        Response.Redirect("DataEntry/Default.aspx");
                    }
                }
                else
                {
                    c2 = new HttpCookie("Data2");
                    c2.Values.Add("id", dt.Rows[0]["name"].ToString());
                    c2.Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies.Add(c2);
                }
            }
            
            if (Request.Cookies["Data"] != null)
            {
                HttpCookie c = Request.Cookies["Data"];
                TextBox1.Text = c.Values["username"];
                TextBox2.Attributes.Add("value", c.Values["password"]);
                cbRememberMe.Checked = true;
            }
            else
            {
                cbRememberMe.Checked = false;
            }
            
            
            
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>تسجيل الدخول الى النظام</title>
    <link href="StyleSheet.css" type="text/css" rel="Stylesheet" rev="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />

            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />

            <br />
            <table dir="rtl" align="center" class="LogInTable">
                <tr>
                    <td rowspan="2">
                        <img src="Images/Key.png" />
                    </td>
                    <td class="Title">الرجاء ادخال اسم المستخدم و كلمة السر</td>
                    <td rowspan="2">
                        <img src="Images/Key.png" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <td>اسم المستخدم</td>
                                <td>
                                    <asp:TextBox CssClass="Text" ID="TextBox1" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>كلمة السر</td>
                                <td>
                                    <asp:TextBox CssClass="Text" ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:CheckBox ID="cbRememberMe" Text="تذكرني في المرة المقبلة" runat="server" /><br />
                                    <asp:CheckBox ID="cbKeepMeLogin" Text="البقاء متصلا" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="Center" colspan="2">
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">دخول</asp:LinkButton>
                                    | 
                                <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">نسيت كلمة السر</asp:LinkButton>
                                </td>
                            </tr>

                            <tr>
                                <td class="Center" colspan="2">
                                    <asp:Image Visible="false" ImageUrl="~/Images/Error.png" ImageAlign="Middle" ID="Image1" runat="server" />
                                    <asp:Label Visible="true" CssClass="Error" ID="Label1" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
