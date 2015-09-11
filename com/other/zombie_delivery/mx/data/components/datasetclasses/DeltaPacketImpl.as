class mx.data.components.datasetclasses.DeltaPacketImpl extends Object implements mx.data.components.datasetclasses.DeltaPacket
{
    var _deltaPacket, _optimized, _source, _keyInfo, _transId, _log, _timestamp, _confInfo;
    function DeltaPacketImpl(src, id, keyInfo, log, conSch)
    {
        super();
        _deltaPacket = new Array();
        _optimized = true;
        _source = src;
        _keyInfo = keyInfo == undefined ? (null) : (keyInfo);
        _transId = id;
        _log = log == undefined ? (false) : (log);
        _timestamp = new Date();
        _confInfo = conSch;
    } // End of the function
    function addItem(item)
    {
        if (item instanceof mx.data.components.datasetclasses.Delta)
        {
            item._owner = this;
            _deltaPacket.push(item);
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function clear()
    {
        _deltaPacket = new Array();
    } // End of the function
    function contains(item)
    {
        var _loc3 = false;
        for (var _loc2 = 0; !_loc3 && _loc2 < _deltaPacket.length; ++_loc2)
        {
            _loc3 = _deltaPacket[_loc2] == item;
        } // end of for
        return (_loc3);
    } // End of the function
    function getIterator()
    {
        return (new mx.utils.IteratorImpl(this));
    } // End of the function
    function getItemAt(index)
    {
        return (_deltaPacket[index]);
    } // End of the function
    function getConfigInfo(info)
    {
        return (_confInfo);
    } // End of the function
    function getKeyInfo()
    {
        return (_keyInfo);
    } // End of the function
    function getLength()
    {
        return (_deltaPacket.length);
    } // End of the function
    function getSource()
    {
        return (_source);
    } // End of the function
    function getTransactionId()
    {
        return (_transId);
    } // End of the function
    function getTimestamp()
    {
        return (_timestamp);
    } // End of the function
    function isEmpty()
    {
        return (_deltaPacket.length == 0);
    } // End of the function
    function removeItem(item)
    {
        return (false);
    } // End of the function
    function logChanges()
    {
        return (_log);
    } // End of the function
} // End of Class
