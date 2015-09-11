class mx.data.components.datasetclasses.DataSetError extends Error
{
    var message;
    function DataSetError(msg)
    {
        super(msg);
    } // End of the function
    function toString()
    {
        return (message);
    } // End of the function
} // End of Class
