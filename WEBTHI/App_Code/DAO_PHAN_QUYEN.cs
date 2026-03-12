using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DataAccess;

/// <summary>
/// Summary description for DAO_PHAN_QUYEN
/// </summary>
public class DAO_PHAN_QUYEN:BASE
{
    public DataSet phanquyen_all()
    {
        try
        {
            return SqlDataAccess.ExecuteDataset(Connection, "sp_phanquyen_all", null);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public DAO_PHAN_QUYEN()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}