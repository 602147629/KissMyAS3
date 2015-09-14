package cooperateCode
{
    import flash.display.*;
    import flash.text.*;
    import message.*;
    import utility.*;

    public class CooperateCodeView extends Object
    {
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _codeInfo:CooperateCodeInformation;

        public function CooperateCodeView(param1:MovieClip)
        {
            this._baseMc = param1;
            this._isoMc = new InStayOut(this._baseMc, true);
            this._isoMc.setIn();
            TextControl.setIdText(this._baseMc.listMc.titleMc.textDt, MessageId.STORAGE_ITEM_GET_DATE);
            var _loc_2:* = this._baseMc.listMc.serialMc.textDt;
            _loc_2.embedFonts = false;
            _loc_2.alwaysShowSelection = true;
            _loc_2.selectable = true;
            return;
        }// end function

        public function release() : void
        {
            this._codeInfo = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            this._baseMc = null;
            return;
        }// end function

        public function setCodeInfo(param1:CooperateCodeInformation) : void
        {
            this._codeInfo = param1;
            if (param1)
            {
                TextControl.setText(this._baseMc.listMc.nameMc.textDt, param1.campaignName);
                TextControl.setText(this._baseMc.listMc.dateMc.textDt, TextControl.createDateString(param1.getTime));
                this._baseMc.listMc.serialMc.textDt.text = param1.serialCode;
                this._baseMc.visible = true;
            }
            else
            {
                TextControl.setText(this._baseMc.listMc.nameMc.textDt, "");
                TextControl.setText(this._baseMc.listMc.dateMc.textDt, "");
                this._baseMc.listMc.serialMc.textDt.text = "";
                this._baseMc.visible = false;
            }
            return;
        }// end function

    }
}
