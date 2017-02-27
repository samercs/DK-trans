<%@ Page Title="تعديل معلومات القاطرة" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PID"] != null)
        {
            if (!Page.IsPostBack)
            {
                TextBox1.Text = DataBase.GetPName("Cars", "Number", "id", Session["PID"].ToString());
                TextBox2.Text = DataBase.GetPName("Cars", "Model", "id", Session["PID"].ToString());
                TextBox3.Text = DataBase.GetPName("Cars", "Type", "id", Session["PID"].ToString());
                DateTime tt;
                if (DateTime.TryParse(DataBase.GetPName("Cars", "Regesterdate", "id", Session["PID"].ToString()), out tt))
                {
                    TextBox4.Text = tt.ToString("MM/dd/yyyy");
                }
                
                
                
            }
        }
        else
        {
            Response.Redirect("Cars.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (Page.IsValid)
        {
            if (DataBase.UpdateData("cars", new string[] { "Number", "Model", "Type", "Regesterdate", "Owner" }, new string[] { TextBox1.Text, TextBox2.Text, TextBox3.Text, TextBox4.Text, DropDownList1.SelectedValue }, "id", Session["PID"].ToString()))
            {
                Message msg = new Message("تم تعديل معلومات القاطرة", true, "cars.aspx", "cars.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            else
            {
                Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "cars.aspx", "cars.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
        }
    }

    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList1.Items.FindByValue(DataBase.GetPName("Cars", "Owner", "id", Session["PID"].ToString())).Selected = true;
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if(!TextBox1.Text.Equals(DataBase.GetPName("Cars","Number","id",Session["PID"].ToString())))
        {
            if (DataBase.GetPName("Cars", "Number", "Number", TextBox1.Text).Trim().Length != 0)
            {
                args.IsValid = false;
            }
            else
            {

                args.IsValid = true;
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>  
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
    
    <center>
        <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">
تعديل معلومات القاطرة
            </td>
        </tr>
        <tr class="tr2">
            <td>
                رقم القاطرة
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال رقم القاطرة" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ControlToValidate="TextBox1" ID="CustomValidator1" runat="server" Text="*" ErrorMessage="رقم القاطرة مدخل" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
                سنة الصنع
                
            </td>
            <td>
                <asp:TextBox ID="TextBox2" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                نوع القاطرة
                
            </td>
            <td>
                <asp:TextBox ID="TextBox3" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                تاريخ الترخيص
                
            </td>
            <td>
                <asp:TextBox ID="TextBox4" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                المالك
                
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID" OnDataBound="DropDownList1_DataBound">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT [ID], [Name] FROM [Owners]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">تعديل</asp:LinkButton> | 
                <a href="Cars.aspx">رجوع</a>
                <br />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    </center>
    </ContentTemplate>
    </asp:UpdatePanel>
 
    
    
</asp:Content>

