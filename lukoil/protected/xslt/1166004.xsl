<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="����[��������/@���='1166004']" mode ="Title">
		������������� ���� ��������
	</xsl:template>

	<xsl:template match="/����[��������/@���='1166004']">
		<xsl:apply-templates select="��������[@���='1166004']"/>
	</xsl:template>

	<xsl:template match="��������[@���='1166004']">
		<p align='right' style='text-align:right'>
			<span style='font-size:11.0pt'>
				����� �� ��� 1166004
			</span>
		</p>
		<p>����� ������</p>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="@�������"/>
			</xsl:for-each>
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="���/@�������"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@���"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@��������"/>
			</xsl:for-each>
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="@������"/>
			</xsl:for-each>
		</div>
		<hr style="height: 1px; border-right-width: 0px;border-left-width: 0px;border-bottom-width: 0px; border-top: 1px solid #000; margin-left:300pt"/>
		<div style="text-align:center; margin-left:300pt; margin-right:0pt;">
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="@�����"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@���"/>
			</xsl:for-each>
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="@�����"/>
			</xsl:for-each>
			<xsl:for-each select="������/������">
				&#160;
			</xsl:for-each>
		</div>
		<div class="headlines">
			(������ ������������ �����������, ���/���; �.�.�.
			��������������� ��������������� (����������� ����), ��� (��� �������))
		</div>
		<p style='font-size:12.0pt;text-align:center'>
			<strong>
				������������� ���� ��������
			</strong>
		</p>
		<span>
			<xsl:apply-templates select="�������/����������/@������� | �������/��/@�����"/>
		</span>
		<div class="line">
			(������������ ������������������� ��������� �����; ��� ���������� ������)
		</div>
		<span>
			��������� ���������� ������������, ���
			<xsl:apply-templates select="���������/@��������"/>
			�
			<xsl:value-of select="translate(���������/@���������,'.',':')"/>
			��� ��������� ����������� <br/>
			�������� � �����<br/>
		</span>
		<xsl:for-each select="���������/������������">
			<span>
				<xsl:apply-templates select="@������������"/>
			</span>
			<div class="line">(������������ �����)</div>
		</xsl:for-each>
		<span>
			����������� ��������� (����������������, �������������):<br/>
		</span>
		<span>
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="@�������"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@�����"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@���"/>
			</xsl:for-each>
			<xsl:for-each select="������/������">
				<xsl:apply-templates select="���/@�������"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@���"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@��������"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@�����"/>
			</xsl:for-each>
		</span>
		<div class="line">
			(������������ �����������, ���/���; �.�.�. ��������������� ��������������� (����������� ����), ��� (��� �������))
		</div>
		<xsl:apply-templates select="������/@E-mail"/>
		<div class="line">
			(����������� ����� �����������)
		</div>
		<span>
			���������� ���������:<br/>
		</span>
		<span>
			<xsl:for-each select="��������/������">
				<xsl:apply-templates select="@�����"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@������"/>
			</xsl:for-each>
			<xsl:for-each select="��������/������">
				<xsl:apply-templates select="@�������"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@�����"/>
				<xsl:text>/</xsl:text>
				<xsl:apply-templates select="@���"/>
			</xsl:for-each>
			<xsl:for-each select="��������/������">
				<xsl:apply-templates select="���/@�������"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@���"/>
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="���/@��������"/>
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="@�����"/>
			</xsl:for-each>
		</span>
		<div class="line">
			(��� ���������� ������)
		</div>
		<xsl:apply-templates select="��������/@E-mail"/>
		<div class="line">
			(����������� ����� ����������)
		</div>
	</xsl:template>
</xsl:stylesheet>