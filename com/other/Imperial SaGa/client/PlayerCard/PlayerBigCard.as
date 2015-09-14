package PlayerCard
{
    import character.*;
    import flash.display.*;
    import layer.*;
    import player.*;
    import resource.*;

    public class PlayerBigCard extends Object
    {
        private var _mcBase:MovieClip;
        private var _mcWeaponIcon:MovieClip;
        private var _layer:LayerPlayerBigCard;
        private var _playerId:int;

        public function PlayerBigCard(param1:MovieClip, param2:int = 0)
        {
            this._mcBase = param1;
            this._layer = new LayerPlayerBigCard();
            this._mcBase.addChild(this._layer);
            this._mcWeaponIcon = ResourceManager.getInstance().createMovieClip(ResourcePath.CARD_PATH + "CardWeaponIcon.swf", "dummyCardBigMc");
            this._layer.getLayer(LayerPlayerBigCard.WEAPON_ICON).addChild(this._mcWeaponIcon);
            this._playerId = Constant.EMPTY_ID;
            this.setPlayerId(param2);
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function release() : void
        {
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            this._mcBase = null;
            return;
        }// end function

        public function show() : void
        {
            this._mcBase.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            var _loc_3:* = null;
            if (this._playerId == param1)
            {
                return;
            }
            this._playerId = param1;
            this._layer.getLayer(LayerPlayerBigCard.CARD).removeChildren();
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (_loc_2)
            {
                _loc_3 = ResourceManager.getInstance().createBitmap(ResourcePath.CARD_BIG_PATH + CharacterConstant.ID_CARD + _loc_2.cardFileName);
                _loc_3.smoothing = true;
                this._layer.getLayer(LayerPlayerBigCard.CARD).addChild(_loc_3);
                _loc_3.x = -_loc_3.width / 2;
                _loc_3.y = -_loc_3.height / 2;
                this._mcWeaponIcon.x = -_loc_3.width / 2;
                this._mcWeaponIcon.y = -_loc_3.height / 2;
                switch(_loc_2.weaponType)
                {
                    case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("sSword");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("sword");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("gSword");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("ax");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("bow");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("club");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_HALBERD:
                    case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("spear");
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                    case CommonConstant.CHARACTER_WEAPONTYPE_NAIL:
                    {
                        this._mcWeaponIcon.markSetMc.gotoAndStop("fight");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.CARD_PATH + "CardWeaponIcon.swf");
            return;
        }// end function

    }
}
