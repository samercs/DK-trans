using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Message
/// </summary>
public class Message
{
    private string txt;
    private bool type;
    private string prevpage;
    private string okpage;
    public Message()
	{
		
	}

    public Message(string txt, bool type, string prevpage, string okpage)
    {
        this.txt = txt;
        this.type = type;
        this.prevpage = prevpage;
        this.okpage = okpage;
    }

    public string TXT
    {
        get
        {
            return this.txt;
        }
    }

    public bool TYPE
    {
        get
        {
            return this.type;
        }
    }

    public string PREVPAGE
    {
        get
        {
            return this.prevpage;
        }
    }

    public string OKPAGE
    {
        get
        {
            return this.okpage;
        }
    }


}
