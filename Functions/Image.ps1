<#
.Synopsis
   ��������ͼƬ
.DESCRIPTION
   ���ݰٷֱȻ������ش�С����ͼƬ
.EXAMPLE
   'C:\1.png' | Resize-Image -Percent -Percentage 0.8
   ��ͼƬ1.png������80%
.EXAMPLE
   'C:\1.png' | Resize-Image -Pixels -Width 600 -Height 400
   ��ͼƬ1.png������600X400����
.EXAMPLE
   dir $home\Pictures\*png | Resize-Image -Percent -Percentage 0.5
   ��'�ҵ�ͼƬ'�µ�����pngͼƬ������50%
.NOTES
   ����: Mosser Lee
   ԭ������: http://www.pstips.net/resize-image.html
#>
Function Resize-Image
{
    param
    (
    [Switch]$Percent,
    [float]$Percentage,
    [Switch]$Pixels,
    [int]$Width,
    [int]$Height
    )
 
    begin
    {
        if( $Percent -and $Pixels)
        {
            Write-Error "���հٷֱ�(Percent)���߷ֱ���(Pixels)���ţ�ֻ����ѡ��һ�£�"
            break
        }
        elseif($Percent)
        {
            if($Percentage -le 0)
            {
              Write-Error "����Percentage��ֵ�������0��"
              break
            }
        }
        elseif($Pixels)
        {
            if( ($Width -lt 1) -or ($Height -lt 1))
            {
              Write-Error "����Width��Height��ֵ������ڵ���1��"
              break
            }
        }
        else
        {
            Write-Error "��ѡ���հٷֱ�(-Percent)���߷ֱ���(-Pixels)���ţ�"
            break
        }
        Add-Type -AssemblyName 'System.Windows.Forms'
        $count=0
 
    }
    process
    {
 
        $img=[System.Drawing.Image]::FromFile($_)
 
        # ���ٷֱ����¼���ͼƬ��С
        if( ($Percentage -gt 0) -and ($Percentage -ne 1.0) )
        {
            $Width = $img.Width * $Percentage
            $Height = $img.Height * $Percentage
        }
 
        # ����ͼƬ
        $size = New-Object System.Drawing.Size($Width,$Height)
        $bitmap =  New-Object System.Drawing.Bitmap($img,$size)
 
        # ����ͼƬ
        $img.Dispose()
        $bitmap.Save($_)
        $bitmap.Dispose()
 
        $count++
    }
    end
    {
        "��ϣ������� $count �˸��ļ�"
    }
}