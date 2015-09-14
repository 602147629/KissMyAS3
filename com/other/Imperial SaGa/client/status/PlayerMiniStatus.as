package status
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import icon.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class PlayerMiniStatus extends Object
    {
        private var _invisibleFlag:int;
        private var _pickupStatus:int;
        private var _playerId:int;
        private var _personal:PlayerPersonal;
        private var _mcBase:MovieClip;
        private var _mcName:MovieClip;
        private var _mcRarity:MovieClip;
        private var _mcEmperor:MovieClip;
        private var _mcGrowth:MovieClip;
        private var _mcPickupParam:MovieClip;
        private var _mcHpBar:MovieClip;
        private var _hpGreenGauge:Gauge;
        private var _hpRedGauge:Gauge;
        private var _spGauge:Gauge;
        private var _rarityIcon:PlayerRarityIcon;
        private var _growthCondtionIcon:GrowthConditionIcon;
        private var _mcStatus:MovieClip;
        private var _warningMessage:String;
        private var _mcWeaponType:MovieClip;
        private var _weaponTypeIcon:WeaponTypeIcon;
        private var _magicTypeIcon:MagicTypeIcon;
        private var _bMagicTypeDisplay:Boolean;
        private var _mcCommanderIcon:MovieClip;
        private var _bCommanderIcon:Boolean;
        private var _timer:Timer;
        public static const INVISIBLE_FLAG_NAME:int = 1;
        public static const INVISIBLE_FLAG_HP:int = 2;
        public static const INVISIBLE_FLAG_RARITY:int = 4;
        public static const INVISIBLE_FLAG_GROWTH:int = 8;
        public static const INVISIBLE_FLAG_PICKUP_PARAM:int = 16;
        public static const INVISIBLE_FLAG_ACTIVITY_PARAM:int = 32;
        public static const INVISIBLE_FLAG_WEAPON:int = 64;
        public static const INVISIBLE_FLAG_ALL:int = 65535;
        public static const NAME_OFFS_NON:int = 0;
        public static const NAME_OFFS_1:int = 1;
        public static const NAME_OFFS_2:int = 2;

        public function PlayerMiniStatus(param1:String, param2:DisplayObjectContainer, param3:PlayerPersonal = null, param4:Boolean = false, param5:int = 0, param6:Boolean = false)
        {
            var _loc_8:* = null;
            this._bMagicTypeDisplay = param4;
            this._mcBase = ResourceManager.getInstance().createMovieClip(param1, "MiniCharaParts");
            this._mcBase.mouseEnabled = false;
            this._mcBase.mouseChildren = false;
            var _loc_7:* = 0;
            while (_loc_7 < this._mcBase.numChildren)
            {
                
                _loc_8 = this._mcBase.getChildAt(_loc_7) as MovieClip;
                if (_loc_8)
                {
                    _loc_8.mouseEnabled = false;
                    _loc_8.mouseChildren = false;
                }
                _loc_7++;
            }
            this._mcBase.gotoAndStop(1);
            param2.addChild(this._mcBase);
            if (param5 == NAME_OFFS_1)
            {
                if (this._mcBase.setCharaNameMcSub01)
                {
                    this._mcName = this._mcBase.setCharaNameMcSub01;
                    this._mcBase.setCharaNameMc.visible = false;
                }
                else
                {
                    this._mcName = this._mcBase.setCharaNameMc;
                }
                if (this._mcBase.setCharaNameMcSub02)
                {
                    this._mcBase.setCharaNameMcSub02.visible = false;
                }
            }
            else if (param5 == NAME_OFFS_2)
            {
                if (this._mcBase.setCharaNameMcSub02)
                {
                    this._mcName = this._mcBase.setCharaNameMcSub02;
                    this._mcBase.setCharaNameMc.visible = false;
                }
                else
                {
                    this._mcName = this._mcBase.setCharaNameMc;
                }
                if (this._mcBase.setCharaNameMcSub01)
                {
                    this._mcBase.setCharaNameMcSub01.visible = false;
                }
            }
            else
            {
                this._mcName = this._mcBase.setCharaNameMc;
                if (this._mcBase.setCharaNameMcSub01)
                {
                    this._mcBase.setCharaNameMcSub01.visible = false;
                }
                if (this._mcBase.setCharaNameMcSub02)
                {
                    this._mcBase.setCharaNameMcSub02.visible = false;
                }
            }
            TextControl.setText(this._mcName.textDt, "");
            this._mcRarity = this._mcBase.setCharaRankMc;
            this._mcEmperor = this._mcBase.EmperorIcon;
            if (this._mcEmperor)
            {
                this._mcEmperor.visible = false;
            }
            this._mcGrowth = this._mcBase.growArrowMc;
            this._mcPickupParam = this._mcBase.statusTextMc;
            this._mcHpBar = this._mcBase.hpBerMc;
            this._hpGreenGauge = null;
            if (this._mcHpBar && this._mcHpBar.hpBarGreenMc)
            {
                this._hpGreenGauge = new Gauge(this._mcHpBar.hpBarGreenMc, 1, 1);
            }
            this._hpRedGauge = null;
            if (this._mcHpBar && this._mcHpBar.hpBarRedMc)
            {
                this._hpRedGauge = new Gauge(this._mcHpBar.hpBarRedMc, 1, 1);
            }
            this._spGauge = null;
            if (this._mcHpBar && this._mcHpBar.spBarMc)
            {
                this._spGauge = new Gauge(this._mcHpBar.spBarMc, 1, 1);
            }
            this._rarityIcon = new PlayerRarityIcon(this._mcRarity);
            this._growthCondtionIcon = new GrowthConditionIcon(this._mcGrowth);
            this._mcStatus = this._mcBase.charaStatusMc;
            this._warningMessage = null;
            this._mcWeaponType = this._mcBase.weaponTypeMc;
            if (this._mcWeaponType)
            {
                this._weaponTypeIcon = new WeaponTypeIcon(this._mcWeaponType);
            }
            this._magicTypeIcon = null;
            if (this._bMagicTypeDisplay)
            {
                this._mcBase.gotoAndStop(2);
                this._magicTypeIcon = new MagicTypeIcon(this._mcBase.attributeTypeSetMc);
            }
            this._mcCommanderIcon = this._mcBase.commanderIconMc;
            if (this._mcCommanderIcon)
            {
                this._mcCommanderIcon.visible = param6;
            }
            this._invisibleFlag = 0;
            this._pickupStatus = StatusConstant.PICKUP_STATUS_NONE;
            this._personal = param3;
            this._playerId = this._personal ? (this._personal.playerId) : (Constant.EMPTY_ID);
            this._timer = new Timer(1000);
            this._timer.addEventListener(TimerEvent.TIMER, this.checkForUpdate);
            this._timer.start();
            this.update();
            return;
        }// end function

        public function get mcBase() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function get charaNull() : MovieClip
        {
            return this._mcBase.charaNull;
        }// end function

        private function checkForUpdate(event:TimerEvent) : void
        {
            if (this._personal && this._spGauge)
            {
                this._personal.updateSp();
                if (this._spGauge.gaugeNow != this._personal.sp)
                {
                    this.update();
                }
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._timer)
            {
                if (this._timer.hasEventListener(TimerEvent.TIMER))
                {
                    this._timer.removeEventListener(TimerEvent.TIMER, this.checkForUpdate);
                }
                this._timer = null;
            }
            if (this._hpGreenGauge)
            {
                this._hpGreenGauge.release();
            }
            this._hpGreenGauge = null;
            if (this._hpRedGauge)
            {
                this._hpRedGauge.release();
            }
            this._hpRedGauge = null;
            if (this._spGauge)
            {
                this._spGauge.release();
            }
            this._spGauge = null;
            this._mcEmperor = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function setPlayerPersonal(param1:PlayerPersonal) : void
        {
            this._personal = param1;
            this._playerId = this._personal ? (this._personal.playerId) : (Constant.EMPTY_ID);
            this.update();
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            this._personal = null;
            this._playerId = param1;
            this.update();
            return;
        }// end function

        public function setInvisible(param1:int) : void
        {
            this._invisibleFlag = param1;
            this._mcName.visible = (this._invisibleFlag & INVISIBLE_FLAG_NAME) == 0;
            this._mcRarity.visible = (this._invisibleFlag & INVISIBLE_FLAG_RARITY) == 0;
            this._mcGrowth.visible = (this._invisibleFlag & INVISIBLE_FLAG_GROWTH) == 0;
            this._mcHpBar.visible = (this._invisibleFlag & INVISIBLE_FLAG_HP) == 0;
            if (this._mcPickupParam)
            {
                this._mcPickupParam.visible = (this._invisibleFlag & INVISIBLE_FLAG_PICKUP_PARAM) == 0;
            }
            if (this._mcStatus)
            {
                this._mcStatus.visible = (this._invisibleFlag & INVISIBLE_FLAG_ACTIVITY_PARAM) == 0 && this._mcStatus.currentLabel != "wait";
            }
            if (this._mcWeaponType)
            {
                this._mcWeaponType.visible = (this._invisibleFlag & INVISIBLE_FLAG_WEAPON) == 0;
            }
            return;
        }// end function

        public function addInvisible(param1:int) : void
        {
            this.setInvisible(this._invisibleFlag | param1);
            return;
        }// end function

        public function subtractInvisible(param1:int) : void
        {
            this.setInvisible(this._invisibleFlag & (INVISIBLE_FLAG_ALL ^ param1));
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

        public function setPosition(param1:int, param2:int) : void
        {
            this._mcBase.x = param1;
            this._mcBase.y = param2;
            return;
        }// end function

        public function getPosition() : Point
        {
            return new Point(this._mcBase.x, this._mcBase.y);
        }// end function

        public function getPositionToGlobal() : Point
        {
            return this._mcBase.localToGlobal(new Point());
        }// end function

        public function setPickupStatus(param1:int) : void
        {
            this._pickupStatus = param1;
            return;
        }// end function

        public function setWarning(param1:String) : void
        {
            this._warningMessage = param1;
            return;
        }// end function

        public function clearWarning() : void
        {
            this._warningMessage = null;
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (this._playerId == Constant.EMPTY_ID)
            {
                return;
            }
            var _loc_1:* = PlayerManager.getInstance().getPlayerInformation(this._playerId);
            if (_loc_1 == null)
            {
                return;
            }
            TextControl.setText(this._mcName.textDt, _loc_1.name);
            this._rarityIcon.setRarity(_loc_1.rarity);
            if (this._personal)
            {
                if (this._mcEmperor)
                {
                    this._mcEmperor.visible = this._personal.isEmperor();
                }
                this.updateGauge();
                if (this._mcGrowth)
                {
                    this._growthCondtionIcon.setGrowthLabel(this._personal.getGrowthLabel());
                }
                if (this._mcPickupParam)
                {
                    switch(this._pickupStatus)
                    {
                        case StatusConstant.PICKUP_STATUS_NONE:
                        case StatusConstant.PICKUP_STATUS_SKILL:
                        {
                            this._mcPickupParam.visible = false;
                            TextControl.setText(this._mcPickupParam.textDt, "");
                            TextControl.setText(this._mcPickupParam.numDt, "");
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_GET_TIME:
                        {
                            this._mcPickupParam.visible = true;
                            _loc_2 = Math.min(9999, (TimeClock.getNowTime() - this._personal.gotTime) / 86400);
                            if (_loc_2 == 0)
                            {
                                TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_GET_TIME_TODAY);
                            }
                            else
                            {
                                TextControl.setText(this._mcPickupParam.textDt, TextControl.formatIdText(MessageId.PLAYER_LIST_SORT_STATUS_GET_TIME_DAYS_AGO, _loc_2));
                            }
                            TextControl.setText(this._mcPickupParam.numDt, "");
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_USE_COUNT:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_BATTLE_COUNT);
                            TextControl.setText(this._mcPickupParam.numDt, this._personal.battleCount.toString());
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_HP:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_HP);
                            TextControl.setText(this._mcPickupParam.numDt, this._personal.hpMax.toString());
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_ATTACK:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_ATTACK);
                            TextControl.setText(this._mcPickupParam.numDt, this._personal.attack.toString());
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_DEFENSE:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_DEFENSE);
                            TextControl.setText(this._mcPickupParam.numDt, this._personal.defense.toString());
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_SPEED:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_SPEED);
                            TextControl.setText(this._mcPickupParam.numDt, this._personal.speed.toString());
                            break;
                        }
                        case StatusConstant.PICKUP_STATUS_RESTORE_TIME:
                        {
                            this._mcPickupParam.visible = true;
                            TextControl.setIdText(this._mcPickupParam.textDt, MessageId.PLAYER_LIST_SORT_STATUS_RESTORE_TIME);
                            TextControl.setText(this._mcPickupParam.numDt, StringTools.timeTextSec(this._personal.getRestoreTimeSec()));
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
                if (this._mcStatus)
                {
                    _loc_3 = "";
                    _loc_4 = "wait";
                    if (this._warningMessage)
                    {
                        _loc_3 = this._warningMessage;
                        _loc_4 = "warning";
                    }
                    if (this._personal.isUseFacility())
                    {
                        switch(this._personal.lastUseFacilityId)
                        {
                            case CommonConstant.FACILITY_ID_TRAINING_ROOM:
                            {
                                _loc_3 = MessageManager.getInstance().getMessage(MessageId.CORRELATION_STATUS_TRAINING);
                                _loc_4 = "training";
                                break;
                            }
                            case CommonConstant.FACILITY_ID_MAGIC_DEVELOP:
                            {
                                _loc_3 = MessageManager.getInstance().getMessage(MessageId.CORRELATION_STATUS_MAGIC_LERNING);
                                _loc_4 = "magicLarning";
                                break;
                            }
                            case CommonConstant.FACILITY_ID_BARRACKS:
                            {
                                _loc_3 = MessageManager.getInstance().getMessage(MessageId.CORRELATION_STATUS_REST);
                                _loc_4 = "rest";
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    TextControl.setText(this._mcStatus.textMc.textDt, _loc_3);
                    this._mcStatus.gotoAndStop(_loc_4);
                    this._mcStatus.visible = (this._invisibleFlag & INVISIBLE_FLAG_ACTIVITY_PARAM) == 0 && this._mcStatus.currentLabel != "wait";
                }
                if (this._mcWeaponType)
                {
                    this._mcWeaponType.visible = (this._invisibleFlag & INVISIBLE_FLAG_WEAPON) == 0;
                    this._weaponTypeIcon.setWeaponType(_loc_1.weaponType);
                }
                if (this._bMagicTypeDisplay)
                {
                    this._magicTypeIcon.setMagicType(_loc_1.magicType);
                }
                if (this._bCommanderIcon)
                {
                    this._mcCommanderIcon.visible = this._bCommanderIcon;
                }
            }
            else
            {
                if (this._mcEmperor)
                {
                    this._mcEmperor.visible = false;
                }
                if (this._mcHpBar)
                {
                    this._mcHpBar.visible = false;
                }
                if (this._mcGrowth)
                {
                    this._mcGrowth.visible = false;
                }
                if (this._mcPickupParam)
                {
                    this._mcPickupParam.visible = false;
                }
                if (this._mcStatus)
                {
                    this._mcStatus.visible = false;
                }
                if (this._mcWeaponType)
                {
                    this._mcWeaponType.visible = false;
                }
                if (this._mcCommanderIcon)
                {
                    this._mcCommanderIcon.visible = false;
                }
            }
            return;
        }// end function

        public function updateGauge() : void
        {
            if (this._mcHpBar == null)
            {
                return;
            }
            var _loc_1:* = this._personal.getHpAtResting();
            var _loc_2:* = this._personal.isDyingAtResting();
            this._mcHpBar.gotoAndStop(_loc_2 ? ("Red") : ("green"));
            if (_loc_2)
            {
                this._hpGreenGauge.hide();
                this._hpRedGauge.show();
                this._hpRedGauge.setMaxGauge(this._personal.hpMax);
                this._hpRedGauge.setGauge(_loc_1);
            }
            else
            {
                this._hpRedGauge.hide();
                this._hpGreenGauge.show();
                this._hpGreenGauge.setMaxGauge(this._personal.hpMax);
                this._hpGreenGauge.setGauge(_loc_1);
            }
            if (this._spGauge)
            {
                this._personal.updateSp();
                this._spGauge.show();
                this._spGauge.setMaxGauge(this._personal.spMax);
                this._spGauge.setGauge(this._personal.sp);
            }
            return;
        }// end function

    }
}
