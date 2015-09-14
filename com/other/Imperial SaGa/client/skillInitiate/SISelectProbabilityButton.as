package skillInitiate
{
    import button.*;
    import flash.display.*;
    import item.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class SISelectProbabilityButton extends Object
    {
        private var _baseMc:MovieClip;
        private var _button:ButtonBase;
        private var _probabilityMc:NumericNumberMc;
        private var _itemIcon:Bitmap;
        private var _selectedMc:MovieClip;
        private var _bInvalid:Boolean;

        public function SISelectProbabilityButton(param1:MovieClip, param2:MovieClip, param3:int, param4:int, param5:Function, param6:Boolean)
        {
            this._baseMc = param1;
            this._selectedMc = param2;
            this._button = ButtonManager.getInstance().addButton(this._baseMc, param5, param4);
            this._button.enterSeId = ButtonBase.SE_DECIDE_ID;
            if (this._baseMc.getChildByName("probabilityNumTopMc") != null)
            {
                this._probabilityMc = new NumericNumberMc(this._baseMc.probabilityNumTopMc.probabilityNumMc, SkillInitiateUtility.getBonusProbability(param4), 0, false);
            }
            this._itemIcon = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(CommonConstant.ITEM_KIND_PAYMENT_ITEM, PaymentItemId.ITEM_REVISION_PROBABILITY));
            this._itemIcon.smoothing = true;
            this._baseMc.itemNull.addChild(this._itemIcon);
            TextControl.setText(this._baseMc.itemNumMc.textDt, SkillInitiateUtility.getItemCost(param3, param4).toString());
            this._bInvalid = param6;
            return;
        }// end function

        public function release() : void
        {
            if (this._button)
            {
                ButtonManager.getInstance().removeButton(this._button);
            }
            if (this._probabilityMc)
            {
                this._probabilityMc.release();
            }
            if (this._itemIcon && this._itemIcon.parent)
            {
                this._itemIcon.parent.removeChild(this._itemIcon);
            }
            this._itemIcon = null;
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            this._button.setDisable(!param1 || this._button.id == Constant.UNDECIDED || this._bInvalid);
            return;
        }// end function

        public function setShowSelectedMc(param1:Boolean) : void
        {
            this._selectedMc.visible = param1;
            return;
        }// end function

    }
}
