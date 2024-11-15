-- createBaseController: ���������������ṹ���������κ��ڲ���״��Բ����������
fn createBaseController shape length width radius wireColorHandle = 
(
    rec = Rectangle length:length width:width name:(uniqueName "FaceControl") wireColor:[0,0,200] displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
    cir = shape radius:radius name:(uniqueName "FaceControlHandle") wireColor:wireColorHandle displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
    cir.parent = rec 
    setTransformLockFlags cir #{3..9}

    -- ���������ÿ�������ǩ
    conName = text text:"������" size:2 wireColor:[255,255,0] pos:[0,6,0] alignment:2 displayRenderMesh:false  font:"����"
    conName.parent = rec
    addModifier conName (meshSelect())
    setTransformLockFlags conName #{1..9}

    -- ���ÿ�������ת
    rec.rotation.x_rotation = 90

    return #(rec, cir)
)

-- ����һ��ͨ�ú�����������λ�ú���ת������
fn configureControllers cir posLimitX posLimitY = 
(
-- 	format "Configuring controller: %\n" cir  -- ��ӡ cir ������Ϣ
    -- ����λ�ÿ�����
    cir.Position.controller = position_list ()
    cir.Position.controller.Available.controller = Position_XYZ ()
    cir.Position.controller[1].controller = Bezier_Position ()
    listctrl.setname cir.Position.controller 1 "Frozen Position"
    listctrl.setname cir.Position.controller 2 "Zero Pos XYZ"
    cir.position.controller.SetActive 2 

    -- ������ת������
    cir.rotation.controller = Rotation_list ()
    cir.rotation.controller.Available.controller = Euler_XYZ ()
    listctrl.setname cir.rotation.controller 1 "Frozen Rotation"
    listctrl.setname cir.rotation.controller 2 "Zero Euler XYZ"
    cir.rotation.controller.SetActive 2 

    -- ����λ������
    fl = float_limit()
    cir.pos.controller[2][1].controller = fl
    fl.limits[#upper_limit].value = posLimitX
    fl.limits[#lower_limit].value = -posLimitX

    fl = float_limit()
    cir.pos.controller[2][2].controller = fl
    fl.limits[#upper_limit].value = posLimitY
    fl.limits[#lower_limit].value = -posLimitY

    fl = float_limit()
    cir.pos.controller[2][3].controller = fl
    fl.limits[#upper_limit].value = 0
    fl.limits[#lower_limit].value = 0
)

-- �������α��������
fn facialControlSquare = 
(
    controllers = createBaseController circle 10 10 1 [200,0,0]
    configureControllers controllers[2] 5 5
    controllers
)

-- �������α��������
fn facialControlBar = 
(
    controllers = createBaseController circle 10 1 1 [200,0,0]
    configureControllers controllers[2] 0 5
    controllers
)


-- ����һ���������������������ÿ�����
fn createAndConfigureController shapeType pos name wireColorHandle = 
(
    rec = Rectangle length:10 width:10 name:(uniqueName "FaceControl") wireColor:[0,0,200] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) displayRenderMesh:false  render_displayRenderMesh:true render_thickness:0.3
    rec.showFrozenInGray = off
    freeze rec

    local cir
    if (shapeType == "circle") then
    (
        cir = circle radius:1 name:name wireColor:wireColorHandle transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) displayRenderMesh:false render_displayRenderMesh:true render_thickness:0.3
    )
    else if (shapeType == "splineShape") then
    (
        cir = splineShape wireColor:wireColorHandle render_displayRenderMesh:true render_thickness:0.3 name:name
        addnewSpline cir
        for i = 1 to pos.count do 
        (
            addKnot cir 1 #corner #line pos[i]
        )
        close cir 1
        updateShape cir
    )

    if isValidNode cir then
    (
        cir.parent = rec
        return #(rec, cir)
    )
    else
    (
        format "Error: Failed to create controller '%'.\n" name
        return undefined
    )
)


-- ����һ�����������������������ı���ǩ
fn createAndConfigureText name pos = 
(
    conName = text text:name size:2 wireColor:[255,255,0] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] pos) alignment:2 displayRenderMesh:false  font:"����"
    conName.showFrozenInGray = off
    freeze conName
    conName
)


-- �������б���UI��������������
fn facialControl =  
(
    strArrayText = #("��üë", "��üë", "����Ƥ", "����", "����Ƥ", "���촽", "�����", "�����", "���촽", "�°�")
    circleCtrlArrayName = #("EyeBrow_R_C", "EyeBrow_L_C", "Eyelid_R_C", "EyeBall_C", "Eyelid_L_C", "UpLip_C", "Lip_R_C", "Lip_L_C", "DownLip_C", "Jaw_C")
    posArray = #([-7,35,0], [7,35,0], [-12,20,0], [0,20,0], [12,20,0], [0,5,0], [-7,-8,0], [7,-8,0], [0,-22,0], [0,-37,0])
    ctrlParent = Rectangle length:90 width:40 cornerRadius:0 transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) wirecolor:yellow  cornerRadius:9 render_displayRenderMesh:true render_thickness:0.3

    for i = 1 to strArrayText.count do 
    (
        local shapeType = if findString strArrayText[i] "��Ƥ" != undefined then "splineShape" else if findString strArrayText[i] "�°�" != undefined then "splineShape" else "circle"

        local pos
        if shapeType == "splineShape" then 
        (
            pos = if findString strArrayText[i] "��Ƥ" != undefined then 
                #([-1.35967,0,0.679834], [-1.35967,-2.21518e-07,1.35967], [-2.71934,0,0], [-1.35967,2.21518e-07,-1.35967], [-1.35967,0,-0.679834], [1.35967,0,-0.679834], [1.35967,2.21518e-07,-1.35967], [2.71934,0,0], [1.35967,-2.21518e-07,1.35967], [1.35967,0,0.679834])
            else 
                #([0,-1.78284e-07,1.0943],[-0.437719,0,0.656578],[-0.218859,0,0.656578],[-0.218859,0,0.218859],[-0.656578,0,0.218859],[-0.656578,0,0.437719],[-1.0943,0,0],[-0.656578,0,-0.437719],[-0.656578,0,-0.218859],[-0.218859,0,-0.218859],[-0.218859,0,-0.656578],[-0.437719,0,-0.656578],[0,1.78284e-07,-1.0943],[0.437719,0,-0.656578],[0.218859,0,-0.656578],[0.218859,0,-0.218859],[0.656578,0,-0.218859],[0.656578,0,-0.437719],[1.0943,0,0],[0.656578,0,0.437719],[0.656578,0,0.218859],[0.218859,0,0.218859],[0.218859,0,0.656578],[0.437719,0,0.656578])
        )

        local controllerArray = createAndConfigureController shapeType pos circleCtrlArrayName[i] [200,0,0]
        local rec = controllerArray[1]
        local cir = controllerArray[2]

        if isValidNode cir then
        (
            local posLimitX = 5
            local posLimitY = (if findString strArrayText[i] "��Ƥ" != undefined then 0 else 5)
            configureControllers cir posLimitX posLimitY  -- Ӧ��λ�ú���ת����
            local conName = createAndConfigureText strArrayText[i] [0,0,6]
            conName.parent = rec
            rec.parent = ctrlParent
            in coordsys parent rec.pos = posArray[i]

            if findString strArrayText[i] "��" != undefined then 
            (
                local originalParent = conName.parent
                conName.parent = undefined -- ��ʱ����ı���ǩ�ĸ�����
                in coordsys parent rotate rec (EulerAngles 0 180 0)
                conName.parent = originalParent -- ��ת��ָ��ı���ǩ�ĸ�����
            )
        )
        else
        (
            format "Error: Invalid controller '%'.\n" circleCtrlArrayName[i]
        )
    )
)




/*


1. createBaseController ����
����: ���������ı���������ṹ������һ�����κ�һ���ڲ���״��Բ�λ�������״���Լ��ı���ǩ��
����:
shape: ��״���ͣ����� circle �� splineShape����
length: ���εĳ��ȡ�
width: ���εĿ��ȡ�
radius: �ڲ���״�İ뾶������Բ�Σ���
wireColorHandle: �ڲ���״����ɫ��
�÷�: ���ڴ���һ���������Ρ�һ���ڲ���״��һ����ǩ�ĸ��Ͽ�������
����ֵ: ����һ���������κ��ڲ���״�����顣
2. configureControllers ����
����: ���ñ����������λ�ú���ת������������λ�����Ƶ����á�
����:
cir: ����������
posLimitX: X���ϵ�λ�����ơ�
posLimitY: Y���ϵ�λ�����ơ�
�÷�: �������ÿ�������λ�ú���ת��Ϊ���Լ�λ�����ơ�
����ֵ: �ޣ�����ֱ���޸� cir ���󣩡�
3. facialControlSquare ����
����: �������α����������
����: �ޡ�
�÷�: ���������ض���״�����õĿ����������ڱ��鶯����
����ֵ: ���ذ������κ�Բ�ο����������顣
4. facialControlBar ����
����: �������α����������
����: �ޡ�
�÷�: ���������ض���״�����Σ������õĿ�������
����ֵ: ���ذ������κ�Բ�ο����������顣
5. createAndConfigureController ����
����: ���ڸ�������״���ͺ�λ�����ݴ��������ÿ�������
����:
shapeType: ��״���ͣ�"circle" �� "splineShape"����
pos: ��״��λ�����ݡ�
name: �����������ơ�
wireColorHandle: ����������ɫ��
�÷�: ����ָ������״���ʹ�������������������λ�ú��������ԡ�
����ֵ: ����ɹ��������򷵻ذ������κ���״��������飻���ʧ�ܣ��򷵻� undefined��
6. createAndConfigureText ����
����: �����������ı���ǩ��
����:
name: �ı����ݡ�
pos: �ı���ǩ��λ�á�
�÷�: Ϊ����������һ���ı���ǩ��
����ֵ: �����ı�����
7. facialControl ����
����: �������б���UI��������
����: �ޡ�
�÷�: ����һ���������������ڶ����С�
����ֵ: �ޣ�����ֱ���ڳ����д�����������




*/

