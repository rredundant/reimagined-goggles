Sub stockcount():
For Each ws In Worksheets
'Dim LastRow As Integer
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
Cells(1, 9).Value = "Ticker"
Cells(1, 10).Value = "Total Stock Volume"
Cells(1, 11).Value = "Amount of Change"
Cells(1, 12).Value = "Percent of Change"
Cells(2, 15).Value = "Greatest % Increase"
Cells(3, 15).Value = "Greatest % Decrease"
Cells(4, 15).Value = "Greatest Total Volume"
Cells(1, 16).Value = "Ticker"
Cells(1, 17).Value = "Value"
runstock = 0
starstockval = Cells(2, 3).Value
endstockval = 0
runstockrow = 2
greatestincrease = 0
Dim greatestincname As String
greatestdecrease = 0
Dim greatestdecname As String
highestvolume = 0
Dim highvolname As String
    For Row = 2 To LastRow
    curstock = Cells(Row, 1).Value
    nexstock = Cells(Row + 1, 1).Value
    curstockval = Cells(Row, 7).Value
        If curstock = nexstock Then
        runstock = runstock + curstockval
        Else
        runstock = runstock + curstockval
        Cells(runstockrow, 9).Value = curstock
        Cells(runstockrow, 10).Value = runstock
        endstockval = Cells(Row, 6).Value
        changestockval = endstockval - starstockval
        perstockval = changestockval / starstockval
        Cells(runstockrow, 11).Value = changestockval
        Cells(runstockrow, 12).Value = perstockval
            If perstockval > 0 Then
            Cells(runstockrow, 12).Interior.ColorIndex = 4
            ElseIf perstockval < 0 Then
            Cells(runstockrow, 12).Interior.ColorIndex = 3
            End If
            If runstock > highestvolume Then
            highestvolume = runstock
            highvolname = curstock
            End If
            If perstockval > greatestincrease Then
            greatestincrease = perstockval
            greatestincname = curstock
            End If
            If perstockval < greatestdecrease Then
            greatestdecrease = perstockval
            greatestdecname = curstock
            End If
        endstockval = 0
        starstockval = Cells(Row + 1, 3).Value
        runstock = 0
        runstockrow = runstockrow + 1
        End If
    Cells(2, 16).Value = greatestincname
    Cells(2, 17).Value = greatestincrease
    Cells(3, 16).Value = greatestdecname
    Cells(3, 17).Value = greatestdecrease
    Cells(4, 16).Value = highvolname
    Cells(4, 17).Value = highestvolume
    Next Row
Next ws
End Sub




