using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BASE
/// </summary>
public class BASE
{
    public string Connection = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
    public BASE()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}