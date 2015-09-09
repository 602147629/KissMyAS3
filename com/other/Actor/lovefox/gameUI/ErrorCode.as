package lovefox.gameUI
{

    public class ErrorCode extends Object
    {

        public function ErrorCode()
        {
            return;
        }// end function

        public static function groupError(param1:int, param2:int) : void
        {
            var _loc_3:* = false;
            switch(param1)
            {
                case CONST_ENUM.C2G_SKILL_UPGRADE:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_LOTTERY:
                {
                    if (param2 == 1)
                    {
                        Config.ui._shopmail._choujiang.jumpMoreCoin();
                    }
                    else if (param2 == 2)
                    {
                        Config.ui._shopmail._choujiang.jumpNotTime();
                    }
                    break;
                }
                case CONST_ENUM.C2G_BOUT:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_POKINGFUN_REFRESH:
                {
                    if (param2 == 0)
                    {
                        Config.ui._cclUI.doRefresh();
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_POKINGFUN:
                {
                    if (param2 != 0)
                    {
                        if (param2 == 401)
                        {
                            Config.ui._cclUI.addHistory(Config._codeWords[param1][param2]);
                        }
                        if (param2 != 1101)
                        {
                            Config.message(Config._codeWords[param1][param2]);
                        }
                    }
                    break;
                }
                case CONST_ENUM.C2G_CHAT:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.CMSG_ITEM_USE:
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    break;
                }
                case CONST_ENUM.C2G_MAP_CHANGE:
                {
                    Config.player.actionLock = false;
                    Config.player.thinkLock = false;
                    if (param2 == 4)
                    {
                        Config.message(Config._codeWords[CONST_ENUM.C2G_MAP_CHANGE][param2]);
                    }
                    else
                    {
                        Config.player.reEnterMap();
                    }
                    break;
                }
                case CONST_ENUM.C2G_USE_TRANSPORT_CRYSTAL:
                {
                    if (param2 == 2)
                    {
                        Config.message(Config._codeWords[CONST_ENUM.C2G_USE_TRANSPORT_CRYSTAL][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_GOTOINSTANCE:
                {
                    Config.message(Config._codeWords[CONST_ENUM.C2G_GOTOINSTANCE][param2]);
                    break;
                }
                case CONST_ENUM.C2G_LEAVEINSTANCE:
                {
                    break;
                }
                case CONST_ENUM.C2G_INSTANCE_CHANGEMAP:
                {
                    Config.player.actionLock = false;
                    Config.player.thinkLock = false;
                    Config.player.reEnterMap();
                    break;
                }
                case CONST_ENUM.C2G_QUEST_REWARD:
                case CONST_ENUM.C2G_QUEST_REWARD1:
                {
                    Config.ui._taskpanel.backlingshang(param2);
                    break;
                }
                case CONST_ENUM.C2G_QUEST_DAILYFRESH:
                case CONST_ENUM.C2G_QUEST_GIVEUP:
                case CONST_ENUM.C2G_QUEST_ACCEPT:
                case CONST_ENUM.C2G_QUEST_AUTO:
                {
                    Config.ui._taskpanel.errtip(param2);
                    break;
                }
                case CONST_ENUM.C2G_QUEST_SETFINISH:
                {
                    Config.ui._taskpanel.guickFinish(param2);
                    break;
                }
                case CONST_ENUM.C2G_QUEST_DAILYACCEPT:
                {
                    Config.ui._taskpanel.dayAccept(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_INVITE:
                {
                    Config.ui._teamUI.backInviteTeam(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_REPLAY_INVITATION:
                {
                    Config.ui._teamUI.backApply(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_APPLY:
                {
                    Config.ui._teamUI.backReloginTeam(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_QUIT:
                {
                    Config.ui._teamUI.backSendMemberLeft(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_REMOVE:
                {
                    Config.ui._teamUI.backSendRemove(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_APPOINT_LEADER:
                {
                    Config.ui._teamUI.backSendLeader(param2);
                    break;
                }
                case CONST_ENUM.C2G_TEAM_REPLAY_APPLICATION:
                {
                    Config.ui._teamUI.backApply(param2);
                    break;
                }
                case CONST_ENUM.C2G_BUY_ITEM_FROM_SHOP:
                case CONST_ENUM.C2G_SELL_ITEM:
                case CONST_ENUM.C2G_BUY_ITEM_FROM_EASYSHOP:
                case CONST_ENUM.C2G_BUY_ITEM_FROM_STORE:
                case CONST_ENUM.C2G_PEND_ORDER:
                case CONST_ENUM.C2G_REVOKE_ORDER:
                case CONST_ENUM.C2G_BUY_ITEM_FROM_CONSIGNSHOP:
                case CONST_ENUM.C2G_ENTER_UMAP:
                case CONST_ENUM.C2G_LEFT_UMAP:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                        if (param2 == 304)
                        {
                            Config.ui._blackmarket.openalert();
                        }
                    }
                    break;
                }
                case CONST_ENUM.C2G_EXPBALL_OPEN:
                {
                    Config.ui._expball.expOpen(param2);
                    break;
                }
                case CONST_ENUM.CMSG_ITEM_ARRANGE:
                {
                    Config.ui._bagUI.backArrange();
                    break;
                }
                case CONST_ENUM.CMSG_EQUIP_POLISH:
                {
                    Config.ui._equiomadepanel.backwasherr(param2);
                    break;
                }
                case CONST_ENUM.CMSG_EQUIP_UPGRADE:
                {
                    if (Config.ui._equiomadepanel._opening)
                    {
                        Config.ui._equiomadepanel.backequperr(param2);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_ITEM_SWAP:
                {
                    Config.ui._charUI.handleItemSwap(param2);
                    break;
                }
                case CONST_ENUM.CMSG_RECYCLE_ITEM:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_EQUIP_TRANSFER:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    else
                    {
                        Config.ui._equiomadepanel.backrideremovefine(param2);
                    }
                    break;
                }
                case CONST_ENUM.C2G_SEND_MAIL:
                {
                    Config.ui._mailpanel.getRequest(param2);
                    break;
                }
                case CONST_ENUM.C2G_SEND_RETOUR:
                {
                    Config.ui._mailpanel.sendItemBack(param2);
                    break;
                }
                case CONST_ENUM.C2G_MAIL_LIST:
                case CONST_ENUM.C2G_MAIL_READ:
                case CONST_ENUM.C2G_TAKE_ATTACH:
                case CONST_ENUM.CMSG_PRODUCE_ITEM:
                case CONST_ENUM.C2G_RECEIVE_GIFT_BAG:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                        if (param1 == CONST_ENUM.CMSG_PRODUCE_ITEM)
                        {
                            Config.ui._producepanel.stoploops();
                        }
                    }
                    break;
                }
                case CONST_ENUM.C2G_GATHER:
                {
                    Config.player.stopGather();
                    if (param2 != 5)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_WOLFHUNT_IN:
                case CONST_ENUM.C2G_VOW:
                case CONST_ENUM.C2G_NEWRECOM_GIFT:
                case CONST_ENUM.C2G_EXCHANGE:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_RELATION_ADD:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_FRIEND_APPLY_RESULT:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_STONE_UPGRADE:
                {
                    if (param2 == 0)
                    {
                        Config.ui._jewelCompound.backjc();
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_GETGIFTSTRING:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_STONE_PUNCH:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    else
                    {
                        Config.ui._equiomadepanel.backjewelopenerr(param2);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_STONE_ENCHASE:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    else
                    {
                        Config.ui._equiomadepanel.backjewelcaserr(param2);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_TRADE_ADDITEM:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_TRADE_REMOVEITEM:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_TRADE_SETMONEY:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_TRADE_LOCKUNLOCK:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_TRADE_SUBMIT:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_OPEN_BOOTH:
                {
                    if (param2 > 0)
                    {
                        Config.ui._stallUI.backerrbooth(param2);
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_BOOTH_ITEM_LIST:
                {
                    if (param2 > 0)
                    {
                        Config.ui._boothUI.backerrboothtrade(param2);
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_BOOTH_TRADE:
                {
                    Config.ui._boothUI.backerrboothtrade(param2);
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_CLOSE_BOOTH:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_GOLDHAND:
                {
                    Skill.selectedSkill = null;
                    if (param2 == 0)
                    {
                        GuideUI.testDoId(139, null, null, [Config.ui._quickUI._goldhandSlot]);
                        var _loc_4:* = Skill;
                        var _loc_5:* = Skill.goldhandTime + 1;
                        _loc_4.goldhandTime = _loc_5;
                        Skill._skillMap[Number(Skill._goldhandSkill.id)].cd = Math.max(Skill._skillMap[Number(Skill._goldhandSkill.id)].cd, 5 * 60000);
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_ITEM_SPLIT:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.CMSG_ITEM_PICKUP:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    _loc_3 = false;
                    if (param2 != 0)
                    {
                        if (Config.ui._playerHead.fcmstatus > 0)
                        {
                            _loc_3 = true;
                        }
                        if (param2 == 433)
                        {
                        }
                        else if (param2 == 401)
                        {
                            _loc_3 = true;
                            BubbleUI.bubble(Config.language("ErrorCode", 1));
                            Config.ui._bagUI.handleFull();
                        }
                        else if (param2 == 433)
                        {
                        }
                        else if (param2 == 432)
                        {
                            _loc_3 = true;
                            BubbleUI.bubble(Config.language("ErrorCode", 2));
                        }
                        else if (param2 == 513)
                        {
                            _loc_3 = true;
                        }
                        if (Config.player.target != null && Config.player.target.type == UNIT_TYPE_ENUM.TYPEID_ITEM_MAP)
                        {
                            if (_loc_3)
                            {
                                Config.player.target.pickDisable = true;
                            }
                            if (Hang.currTarget == Config.player.target)
                            {
                                Hang.currTarget = null;
                            }
                            Config.player.target = null;
                        }
                    }
                    break;
                }
                case CONST_ENUM.C2G_PET_MAKEUP:
                {
                    if (param2 == 0)
                    {
                        Config.ui._petPanel.petflag = false;
                    }
                    break;
                }
                case CONST_ENUM.C2G_PET_MAKEUP_OUT:
                {
                    if (param2 == 0)
                    {
                        Config.ui._petPanel.petflag = true;
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_RELIFE:
                {
                    if (param2 == 2)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][304]);
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PET_CATCH:
                case CONST_ENUM.C2G_PET_FIXSOUL:
                case CONST_ENUM.C2G_PET_GROW:
                case CONST_ENUM.C2G_PET_EXTRACT:
                case CONST_ENUM.C2G_PET_FEEDING:
                case CONST_ENUM.C2G_PET_SKILLSLOT_UNLOCK:
                case CONST_ENUM.C2G_PET_SKILL_LEARN:
                case CONST_ENUM.C2G_PET_SKILL_REMOVE:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    else if (param1 == CONST_ENUM.C2G_PET_CATCH)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    else if (param1 == CONST_ENUM.C2G_PET_SKILL_LEARN)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    else if (param1 == CONST_ENUM.C2G_PET_FIXSOUL)
                    {
                        GuideUI.testDoId(221);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PET_POLISH:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                        Config.ui._petPanel.washbtn.enabled = true;
                    }
                    break;
                }
                case CONST_ENUM.C2G_BUY_OFFLINE_EXP:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    if (param2 == 2)
                    {
                        Config.ui._onlineExpn.alertfun();
                    }
                    break;
                }
                case CONST_ENUM.C2G_PLAYER_PORTOL:
                {
                    if (param2 != 0)
                    {
                        Config.player.actionLock = false;
                        Config.player.thinkLock = false;
                    }
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_LINE_CHANGE:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_RECOMMEND_COMPLETE:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_MOUNT_TRANSFERCOLOR:
                {
                    if (param2 == 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_INSTANCE_BALLCHARGE:
                {
                    if (param2 == 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    else if (param2 == 1)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_INSTANCE_BOUT:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_MONEYGIFT_QUERY:
                {
                    Config.message(Config._codeWords[CONST_ENUM.C2G_MONEYGIFT_QUERY][param2]);
                    break;
                }
                case CONST_ENUM.C2G_MONEYGIFT_GET:
                {
                    Config.message(Config._codeWords[CONST_ENUM.C2G_MONEYGIFT_GET][param2]);
                    break;
                }
                case CONST_ENUM.C2G_GIFT_CODE:
                {
                    if (param2 == 0)
                    {
                        AlertUI.alert(Config.language("ErrorCode", 3), Config.language("ErrorCode", 4), [Config.language("ErrorCode", 5)]);
                    }
                    else
                    {
                        Config.message(Config._codeWords[CONST_ENUM.C2G_GIFT_CODE][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_SETTOP:
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    break;
                }
                case CONST_ENUM.C2G_BDG_ENTER:
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    break;
                }
                case CONST_ENUM.C2G_DUEL_INVITE:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_LOAD_SUIT_RUNE:
                {
                    if (param2 == 0)
                    {
                        Config.ui._suitFit.backsuss();
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_STONE_DISMOUNT:
                {
                    if (param2 == 0)
                    {
                        Config.ui._equiomadepanel.backjewerr();
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_AUCTION_BID:
                {
                    if (param2 == 623)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_OLDUSER_GET:
                {
                    Config.ui._activeprize.backpirzerr(param2);
                    break;
                }
                case CONST_ENUM.C2G_PK_ACTIVITY_GROUP_INFO:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PK_ACTIVITY_REQUEST_SIGNUP:
                {
                    if (param2 == 0)
                    {
                        Config.ui._pkrace.closewin();
                    }
                    else if (param2 == 304)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PK_ACTIVITY_REQUEST_ENTER:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PK_ACTIVITY_SCHEDULE_INFO:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_EXPBALL_BUYEXP:
                case CONST_ENUM.C2G_EXPBALL_ITEMBUYEXP:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_ENTER_SKYTOWER:
                {
                    Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    break;
                }
                case CONST_ENUM.C2G_GUILDSHOP_LEVELUP:
                case CONST_ENUM.C2G_GUILDSOURCE_DONATION:
                case CONST_ENUM.C2G_GUILDSHOP_BUY:
                {
                    if (param2 == 0)
                    {
                        if (param1 == CONST_ENUM.C2G_GUILDSHOP_LEVELUP)
                        {
                            Config.ui._gangs.backUpGildShop();
                        }
                        else if (param1 == CONST_ENUM.C2G_GUILDSOURCE_DONATION)
                        {
                            Config.ui._gangs.backSource();
                        }
                        else if (param1 == CONST_ENUM.C2G_GUILDSHOP_BUY)
                        {
                        }
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_TERRITORY_ENTER:
                {
                    if (param2 != 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_ESCORT_ACCEPT_MISSION:
                {
                    if (param2 != 0)
                    {
                        if (param2 == 1012)
                        {
                            Config.ui._transport.close();
                            Config.ui._transport.addevent();
                        }
                        if (param2 == 1011)
                        {
                            Config.ui._transport.addevent();
                        }
                        if (param2 == 1015 || param2 == 1016 || param2 == 1017)
                        {
                            Config.ui._transport.alertinfor(param2);
                            return;
                        }
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_ARENA1V1_SIGN:
                {
                    Config.ui._interPkPanel.backSign(param2);
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_ARENA_LEAVE:
                {
                    Config.ui._interPkPanel.backLeftPk();
                    break;
                }
                case CONST_ENUM.C2G_ARENA1V1_IN:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_ARENA1V1_CANCEL:
                {
                    Config.ui._interPkPanel.backCancelPk(param2);
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_REAL_EQUIP_TRANSFER:
                {
                    if (param2 == 0)
                    {
                        Config.ui._equiomadepanel.removequpback();
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PET_MERGE_REQUEST:
                case CONST_ENUM.C2G_PET_MERGE_RESPONSE:
                {
                    if (param2 == 0)
                    {
                        if (param1 == CONST_ENUM.C2G_PET_MERGE_REQUEST)
                        {
                            Config.ui._petPanel.backMix();
                        }
                        else if (param1 == CONST_ENUM.C2G_PET_MERGE_RESPONSE)
                        {
                            Config.ui._petPanel.reMix();
                        }
                    }
                    else
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_FIGHTSPIRIT_LEVELUP:
                {
                    if (param2 == 0)
                    {
                        GuideUI.testDoId(34);
                    }
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_FIGHTSPIRIT_CHANGE:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_QQ_GIFT:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_VIP_GETBOX:
                {
                    Config.message(Config._codeWords[param1][param2]);
                    break;
                }
                case CONST_ENUM.C2G_SKYTOWER2_GET_REWARD:
                case CONST_ENUM.C2G_ENTER_SKYTOWER2:
                case CONST_ENUM.C2B_GUILDVS_ENROLL:
                case CONST_ENUM.C2B_GUILDVS_LIST:
                case CONST_ENUM.C2B_GUILDVS_ENTER:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_GUILDVS_CHANGEMAP:
                {
                    if (param2 > 0)
                    {
                        Config.player.actionLock = false;
                        Config.player.thinkLock = false;
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.G2C_FLAG_LIST:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_PETPOLISH:
                {
                    if (param2 > 0)
                    {
                    }
                    break;
                }
                case CONST_ENUM.C2G_PETPOLISH_SAVE:
                {
                    if (param2 == 0)
                    {
                        Config.ui._petPanel.onHammerSave();
                    }
                    break;
                }
                case CONST_ENUM.C2G_IMPROVE_ITEM:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                        Config.ui._producepanel.stoptimer();
                    }
                    break;
                }
                case CONST_ENUM.C2G_XIUXING_START:
                case CONST_ENUM.C2G_XIUXING_AWARD:
                case CONST_ENUM.C2G_XIUXING_TERMINAL:
                case CONST_ENUM.C2G_GODATTRIBUTE_UPGRADE:
                case CONST_ENUM.C2G_ENTER_ACCGUARD:
                case CONST_ENUM.C2B_MULTISKYTOWER_TEAMJOIN:
                case CONST_ENUM.C2B_MULTISKYTOWER_PLAYERJOIN:
                case CONST_ENUM.C2G_ENTER_MULTISKYTOWER:
                case CONST_ENUM.C2G_MULTISKYTOWER_REWARD:
                case CONST_ENUM.C2B_TEAM_KICKOUT_MEMBER:
                {
                    if (param2 > 0)
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_SEND_FLOWER:
                {
                    if (param2 == 0)
                    {
                        Config.ui._giveflower.backsessus();
                    }
                    else
                    {
                        Config.message(Config._codeWords[param1][param2]);
                    }
                    break;
                }
                case CONST_ENUM.C2G_NIUDAN_NEN:
                {
                    if (param2 == 1)
                    {
                        Config.message("代币不够");
                    }
                    else if (param2 == 2)
                    {
                        Config.message("背包空间不足");
                    }
                    else if (param2 == 3)
                    {
                        Config.message("等级不够");
                    }
                    break;
                }
                case CONST_ENUM.C2G_NIUDAN_NEN:
                {
                    if (param2 == 1)
                    {
                        Config.message("代币不够");
                    }
                    else if (param2 == 2)
                    {
                        Config.message("背包空间不足");
                    }
                    else if (param2 == 3)
                    {
                        Config.message("等级不够");
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
