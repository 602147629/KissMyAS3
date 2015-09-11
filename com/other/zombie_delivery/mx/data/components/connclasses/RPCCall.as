class mx.data.components.connclasses.RPCCall extends MovieClip
{
    var _visible, dispatchEvent, results, multipleSimultaneousAllowed, refreshAndValidate, suppressInvalidCalls;
    function RPCCall()
    {
        super();
        mx.events.EventDispatcher.initialize(this);
        mx.data.binding.ComponentMixins.initComponent(this);
        _visible = false;
    } // End of the function
    function bumpCallsInProgress(amount)
    {
        callsInProgress = callsInProgress + amount;
        this.notifyStatus("StatusChange", {callsInProgress: callsInProgress});
    } // End of the function
    function notifyStatus(code, data)
    {
        var _loc2 = new Object();
        _loc2.type = "status";
        _loc2.code = code;
        _loc2.data = data;
        this.dispatchEvent(_loc2);
    } // End of the function
    function setResult(r)
    {
        results = r;
        this.dispatchEvent({type: "result"});
    } // End of the function
    function triggerSetup(needsParams)
    {
        if (!multipleSimultaneousAllowed && callsInProgress > 0)
        {
            this.notifyStatus("CallAlreadyInProgress", callsInProgress);
            return (false);
        } // end if
        this.dispatchEvent({type: "send"});
        if (needsParams && !this.refreshAndValidate("params") && suppressInvalidCalls)
        {
            this.notifyStatus("InvalidParams");
            return (false);
        } // end if
        return (true);
    } // End of the function
    function onUpdate()
    {
        _visible = true;
    } // End of the function
    var callsInProgress = 0;
} // End of Class
