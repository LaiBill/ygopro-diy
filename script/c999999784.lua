--虹纹之龙
function c999999784.initial_effect(c)
	--同调召唤
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xf70),aux.NonTuner(Card.IsRace,RACE_WARRIOR),1)
	c:EnableReviveLimit()
	--①
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c999999784.atkup)
	c:RegisterEffect(e1)
	--②
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(999999784,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCost(c999999784.cost)
	e2:SetOperation(c999999784.spop)
	c:RegisterEffect(e2)
	 --这张卡同调召唤成功的回合结束时才能发动。从卡组把1张「虹纹」卡从游戏中除外。
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetCondition(c999999784.spcon)
    e3:SetOperation(c999999784.regop)
    c:RegisterEffect(e3)
	--破坏效果
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(32864,6))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c999999784.tdcost)
	e4:SetTarget(c999999784.tdtg)
	e4:SetOperation(c999999784.tdop)
	c:RegisterEffect(e4)
end
function c999999784.spcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO
end
function c999999784.regop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(999999784,1))
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetTarget(c999999784.target)
    e1:SetOperation(c999999784.retop)
    e1:SetReset(RESET_EVENT+0x1ee0000+RESET_PHASE+PHASE_END)
    c:RegisterEffect(e1)
end
function c999999784.tgfilter(c)
    return c:IsSetCard(0xf70) and c:IsAbleToRemove()
end
function c999999784.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c999999784.tgfilter,tp,LOCATION_DECK,0,1,nil) end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_DECK)
end
function c999999784.retop(e,tp,eg,ep,ev,re,r,rp)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g=Duel.SelectMatchingCard(tp,c999999784.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
    if g:GetCount()>0 then
        Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
    end
end
function c999999784.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf70)
end
function c999999784.atkup(e,c)
	return Duel.GetMatchingGroupCount(c999999784.atkfilter,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)*100
end
function c999999784.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xf70) and c:IsAbleToDeckAsCost()
end
function c999999784.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c999999784.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMS_TODECK)
	local g=Duel.SelectMatchingCard(tp,c999999784.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,2,nil)
	if g:GetCount()~=2 then return end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c999999784.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_REMOVED+LOCATION_GRAVE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	if Duel.GetCurrentPhase()==PHASE_STANDBY and Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,1)
	end
	e1:SetCountLimit(1)
	e1:SetOperation(c999999784.spop2)
	c:RegisterEffect(e1)
	c:SetTurnCounter(0)
end
function c999999784.filter1(c)
	return c:IsSetCard(0xf70) and c:IsAbleToRemove()
end
function c999999784.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	if ct==1 then
		Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c999999784.filter1,tp,LOCATION_DECK,0,1,1,nil)
		local tg=g:GetFirst()
		if tg==nil then return end
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
		Duel.SpecialSummonComplete()
	end
end
function c999999784.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,999999784)==0
	and Duel.IsExistingTarget(c999999784.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c999999784.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,2,nil)
	if g:GetCount()~=2 then return end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
	Duel.RegisterFlagEffect(tp,999999784,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c999999784.tdfilter(c)
	return c:IsDestructable()
end
function c999999784.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c999999784.tdfilter,tp,OCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c999999784.tdfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c999999784.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c999999784.tdfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end