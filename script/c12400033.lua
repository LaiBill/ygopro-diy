--超震动光子剑
function c12400033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c12400033.target)
	e1:SetOperation(c12400033.operation)
	c:RegisterEffect(e1)
	--Atk,def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c12400033.value)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c12400033.eqlimit)
	c:RegisterEffect(e3)
	--equip
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c12400033.eqcon)
	e4:SetTarget(c12400033.eqtg)
	e4:SetOperation(c12400033.eqop)
	c:RegisterEffect(e4)
end
function c12400033.eqlimit(e,c)
	return c:IsRace(RACE_FAIRY)
end
function c12400033.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c12400033.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c12400033.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c12400033.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c12400033.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c12400033.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c12400033.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsAttribute,0,LOCATION_GRAVE,LOCATION_GRAVE,nil,ATTRIBUTE_WIND)*200
end
function c12400033.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP) and c:IsReason(REASON_DESTROY) and c:CheckUniqueOnField(tp)
end
function c12400033.cfilter(c)
	return c:IsSetCard(0xabd)
end
function c12400033.eqfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FAIRY)
end
function c12400033.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingTarget(c12400033.cfilter,tp,LOCATION_GRAVE,0,1,nil) and Duel.IsExistingTarget(c12400033.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c12400033.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE+CATEGORY_EQUIP,g,1,0,0)
end
function c12400033.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or not Duel.IsExistingTarget(c12400033.eqfilter,tp,LOCATION_MZONE,0,1,nil) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local cg=Duel.SelectTarget(tp,c12400033.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local c=cg:GetFirst()
	local tg=sg:GetFirst()
	if Duel.Equip(tp,tg,c) then
		--Add Equip limit
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c12400033.eqlimit1)
		e1:SetLabelObject(c)
		tg:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_SET_CONTROL)
		e2:SetValue(tp)
		e2:SetReset(RESET_EVENT+0x1fc0000)
		tg:RegisterEffect(e2)
	end
end
function c12400033.eqlimit1(e,c)
	return c==e:GetLabelObject()
end