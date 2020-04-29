VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "AppPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ����ģ������Emerald������ ҳ������� ģ��
'======================================
'   ҳ�������
    Dim Page As GPage
'======================================

Public Sub Update()
    'Ӧ�ý���ÿһ֡ˢ�»���õķ�����ҳ�����i��������ڴ˴���
    
    Page.Clear argb(0, 0, 0, 0) '��ջ���

    '================================================================
    '   ʾ������������
    '   Page.Writes "��������", 20,20, Color:=argb(255, 0, 0, 0)
    '================================================================
    Dim Pass As Long, alpha As Single, CircleAlpha As Single
    Pass = Music.position * 1000 - time

    On Error Resume Next
    For I = 1 To UBound(CurrentObjects)
        With CurrentObjects(I)
            If .time - o.SliderMultiplier * 500 - 1000 > Pass Then Exit For
            If Abs(.time - Pass) <= (o.SliderMultiplier * 500) Then
                If .time > Pass Then alpha = 0: CircleAlpha = 0 '1 - alpha
                If .time <= Pass Then alpha = 1 - Cubic((Pass - .time) / (o.SliderMultiplier * 500), 0, 1, 1, 1): CircleAlpha = 0 '1 - (Pass - .time) / (o.SliderMultiplier * 300)
                Page.DrawImage "win" & IIf(alpha < 0.9, "lost", "") & ".png", .X / 700 * GW + 50, .y / 560 * GH + 50, alpha:=alpha ', pos:=posOnCenter
                'DrawBox.Circle (.X / 700 * DrawBox.ScaleWidth + 50, .Y / 560 * DrawBox.ScaleHeight + 50), 20, RGB(255 - alpha * 255, 255 - alpha * 255, 255 - alpha * 255)
                'If alpha <> 0 Then DrawBox.Circle (.X / 700 * DrawBox.ScaleWidth + 50, .Y / 560 * DrawBox.ScaleHeight + 50), 20 + 40 * CircleAlpha, RGB(alpha * 255, 255 - alpha * 255, 255 - alpha * 255)
                If (Not .sound Is Nothing) And alpha > 0 Then
                    If .sound.Volume <> 0.6 Then
                        .sound.Volume = 0.6
                        .sound.Play
                    End If
                End If
            End If
            If Not .sound Is Nothing Then
                If .sound.IsPlaying = False And .sound.Volume = 0.6 Then
                    .sound.Dispose
                    Set .sound = Nothing
                End If
            End If
        End With
    Next
    'DrawBox.Refresh
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub AnimationMsg(id As String, msg As String)
    '������Ϣ����
End Sub
Public Sub Enter()
    'ҳ������¼�
End Sub
Public Sub Leave()
    'ҳ���뿪�¼�
End Sub
Public Sub Gotfocus()
    '����ȡ�ý����¼�
End Sub
Public Sub Lostfocus()
    '����ʧȥ�����¼�
End Sub
Public Sub AnimationDone(id As Integer)
    '�������Ž����¼�
    'id�������Ķ���ID
End Sub
Private Sub Class_Initialize()
    Set Page = New GPage  '����ҳ�������
    Page.Create Me  '�����������������
    Page.Res.NewImages App.path & "\assets", 0.8 '������Դ
    ECore.Add Page, "AppPage"  '����ҳ��
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub