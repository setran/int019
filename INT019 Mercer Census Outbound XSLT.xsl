<?xml version="1.0" encoding="UTF-8"?>
<!-- File Information
     Filename: INT019 Mercer Census Outbound XSLT.xsl
     Developed by: Luanne Holtzclaw
     Last update: 2016.04.27
     Last updated by: Luanne Holtzclaw
 
     Update Log:
     2015.11.06 Initial build
     2015.11.16 Update of file spec
     2015.12.10 Added Header record, changed a couple of fields 
     2016.03.16 Changed to Doc Tran, Added XTT for validation
     2016.04.27 Update to header
     2016.05.04 Add ELIG_CHNG_DATE
    Please Note:
        This XSLT is ONLY associated with the Workday custom report listed for this transformation.  If you copy this XSLT for a new report
        you must update the xmlns:wd declaration below to reflect the different report name!   From the report in Workday, view URLS, then view WSDL.
        Take the urn value on that page and paste in above.
 
        In the Workday report output xml data elements will have unique navigation paths depending on the data object and the object type.
        You must properly use this navigation to reference each of the report output data elements or they will not show up in your output!
 
        Logic processing in this document has been kept to an absolute minimum, and this document should only be used to control the layout of the data.
        Any additional data manipulation should be done at source in Workday whenever possible using.

-->



<xsl:stylesheet exclude-result-prefixes="xsl" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:wd="urn:com.workday.report/CRINT019_Mercer_Census_Outbound"
    xmlns:xtt="urn:com.workday/xtt">
    <!-- <xsl:output method="text"/>-->
    <!--LineFeed Variable - Please Note: Line feed is only used for testing outside WD, xtt:separator="&#xd;&#xa;" controls linespacing in WD-->
    <xsl:variable name="linefeed" select="'&#xd;&#xa;'"/>


    <xsl:template match="/">

        <File  xtt:separator="&#xd;&#xa;" xtt:align="left" xtt:severity="error">
            <!-- Header Record  -->
            <Header>
            <xsl:text>EID,SSN,PIN,EMPLOYEE STATUS,LAST NAME,FIRST NAME,MIDDLE NAME,DOB,ADDRESS LINE 1,ADDRESS LINE 2,ADDRESS LINE 3,ADDRESS CITY,ADDRESS STATE,ADDRESS ZIP,COUNTRY CODE,WORK PHONE,EVENING PHONE,EMAIL ADDRESS,FILE #,GENDER,GROUP STATUS,SALARY,BENEFIT SALARY,PAY RATE TYPE,PAY PERIODS PER YEAR,SMOKER STATUS,MARITAL STATUS,EMPLOYEE TYPE,HIRE DATE,REHIRE DATE,OCCUPATION,PAYROLL NUMBER,LOCATION,LOCATION CODE,DEPARTMENT,DEPARTMENT CODE,DIVISION,MISC. IDENTIFIER,TERMINATION DATE,TERMINATION REASON CODE,LOA DATE,LOA REASON,SALARY CHANGE DATE,FULL_PART_TIME,REG_TEMP,EMPL_STATUS,STD_HOURS,FTE,OFFICER_CD,SAV_ELIG,RET_COST,VISA_CODE,RETIREMENT_DATE,LTD_EFFDT,DATE_OF_DEATH,LOA_RETURN_DATE,ELIG_CHNG_DATE,TERMINATION_RECORD</xsl:text>
            </Header>
            <!-- Worker Record  -->


            <xsl:for-each select="/wd:Report_Data/wd:Report_Entry">
                <Record xtt:separator="," xtt:quotes="csv" xtt:targetWID="{wd:WID}">
                    
       <!-- Omit Records with missing required fields -->
                   
                    
                    <xsl:choose>
                        <xsl:when test="not(exists(wd:Empl_ID))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:SSN))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:PIN))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Emp_Status))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Last_Name))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:First_Name))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:DOB))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Address_1))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Address_City))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>

                        <!-- HHMI -Selma Tran - 09/14/2016 Corrected code so that -->
                        <!-- Employees with a foreign Country value on the address also get  --> 
                        <!-- included on the file. The Old code required that every address -->
                        <!-- enters a STATE and when it didn't, the record would get omitted -->
                        <!-- from the file.  --> 
 
                         
                        <xsl:when test="not(exists(wd:Address_State))">
                            <xsl:if test="wd:Country_Code='USA'">                                 
                               <xsl:attribute name="xtt:omit">
                                   <xsl:text>true</xsl:text>
                               </xsl:attribute>
                            </xsl:if>
                        </xsl:when>

                        <xsl:when test="not(exists(wd:Gender))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Group_Status))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Salary))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Pay_Rate_Type))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Hire_Date))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Full_Part_Time))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="not(exists(wd:Reg_Temp))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>

                        <xsl:when test="not(exists(wd:Empl_Status))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>

                        <xsl:when test="not(exists(wd:Officer_Code))">
                            <xsl:attribute name="xtt:omit">
                                <xsl:text>true</xsl:text>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>

<!-- This section is writing to output -->

                    <EID xtt:required="true">
                        <xsl:value-of select="(wd:Empl_ID)"/>
                    </EID>
                    <SSN xtt:required="true">
                        <xsl:value-of select="(wd:SSN)"/>
                    </SSN>
                    <PIN xtt:required="true">
                        <xsl:value-of select="(wd:PIN)"/>
                    </PIN>
                    <EmployeeStatus xtt:required="true">
                        <xsl:value-of select="(wd:Emp_Status)"/>
                    </EmployeeStatus>
                    <LastName xtt:required="true">
                        <xsl:value-of select="(wd:Last_Name)"/>
                    </LastName>
                    <FirstName xtt:required="true">
                        <xsl:value-of select="(wd:First_Name)"/>
                    </FirstName>
                    <MiddleName>
                        <xsl:value-of select="(wd:Middle_Name)"/>
                    </MiddleName>
                    <DOB xtt:required="true">
                        <xsl:value-of select="format-date(wd:DOB, '[M01]/[D01]/[Y0001]')"/>
                    </DOB>
                    <Address1 xtt:required="true">
                        <xsl:value-of select="(wd:Address_1)"/>
                    </Address1>
                    <Address2>
                        <xsl:value-of select="(wd:Address_2)"/>
                    </Address2>
                    <Address3>
                        <xsl:value-of select="(wd:Address_3)"/>
                    </Address3>
                    <AddressCity xtt:required="true">
                        <xsl:value-of select="(wd:Address_City)"/>
                    </AddressCity>

                    <!-- HHMI - Selma Tran - 09/14/2016 Added validation so that the STATE is -->
                    <!-- required only when the Country is USA. -->                       
                    <xsl:choose>
                        <xsl:when test="wd:Country_Code= 'USA'">                            
                            <AddressState xtt:required="true">
                               <xsl:value-of select="(wd:Address_State)"/>
                            </AddressState>
                        </xsl:when>
                        <xsl:otherwise>
                            <AddressState>
                                <xsl:value-of select="(wd:Address_State)"/>
                            </AddressState>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <AddressZip xtt:required="true" xtt:severity="warning">
                        <xsl:value-of select="(wd:Address_Zip)"/>
                    </AddressZip>
                    <CountryCode>
                        <xsl:value-of select="(wd:Country_Code)"/>
                    </CountryCode>
                    
                    <!--  HHMI - Selma Tran - 09/14/2016 Commented Code for WorkPhone and added new code -->
                    <!-- to correct the issue with phone digits getting dropped from the file.  --> 
                    <!-- The old code was assuming that every phone was formatted with hyphens in Wday and when it didn't, it --> 
                    <!-- wouldn't get reported correctly on the file.  -->
                    <!-- ex. Workday #: 703-1112345  would be included on the file as  703111345.  The 2 would be missing. --> 
                    
                    <WorkPhone>     
                     <!-- <xsl:value-of select="concat(substring(wd:Work_Phone, 2, 3), substring(wd:Work_Phone, 7, 3), substring(wd:Work_Phone, 11, 4))"/> -->         
                                                
                        <xsl:value-of select="translate(translate(translate(wd:Work_Phone,'(', ''), ') ', '-'), '-', '')"/>
                    </WorkPhone>   
                                        
                    
                    <!--  HHMI - Selma Tran - 09/14/2016 Commented code for HOMEPhone and added new code -->
                    <!-- to correct the issue with phone digits getting dropped from the file.  --> 
                    <!-- This code was assuming that every phone is formatted with hyphens in Wday and when it didn't, it --> 
                    <!-- wouldn't get reported correctly on the file.  -->
                    <!-- ex. Workday #: 703-1112345  would be included on the file as  703111345.  The 2 would be missing. --> 
                    
                   <HomePhone>                                                                   
                      <!-- <xsl:value-of select="concat(substring(wd:Home_Phone, 2, 3), substring(wd:Home_Phone, 7, 3), substring(wd:Home_Phone, 11, 4))"/> -->
                       
                       <xsl:value-of select="translate(translate(translate(wd:Home_Phone,'(', ''), ') ', '-'), '-', '')"/>
                    </HomePhone> 
                    
                    
                    <Email>
                        <xsl:value-of select="(wd:Email)"/>
                    </Email>
                    <FileNumber>
                        <xsl:text>''</xsl:text>
                    </FileNumber>
                    <Gender xtt:required="true">
                        <xsl:value-of select="(wd:Gender)"/>
                    </Gender>
                    <GroupStatus xtt:required="true">
                        <xsl:value-of select="(wd:Group_Status)"/>
                    </GroupStatus>
                    <Salary xtt:required="true">
                        <xsl:value-of select="(wd:Salary)"/>
                    </Salary>
                    <BenefitSalary xtt:required="true">
                        <xsl:value-of select="(wd:Benefit_Salary)"/>
                    </BenefitSalary>
                    <PayRateType xtt:required="true" xtt:severity="warning">
                        <xsl:value-of select="(wd:Pay_Rate_Type)"/>
                    </PayRateType>
                    <PayPeriodsPerYear> 
                        <xsl:value-of select="(wd:Pay_Periods_Per_Year)"/>
                    </PayPeriodsPerYear>
                    <Smoker>
                        <xsl:value-of select="(wd:Smoker_Status)"/>
                    </Smoker>
                    <MaritalStatus>
                        <xsl:value-of select="(wd:Marital_Status)"/>
                    </MaritalStatus>
                    <EmplType>
                        <xsl:value-of select="(wd:Empl_Type)"/>
                    </EmplType>
                    <HireDate xtt:required="true">
                        <xsl:value-of select="format-date(wd:Hire_Date, '[M01]/[D01]/[Y0001]')"/>
                    </HireDate>
                    <ReHireDate>
                        <xsl:value-of select="format-date(wd:Rehire_Date, '[M01]/[D01]/[Y0001]')"/>
                    </ReHireDate>
                    <Occupation>
                        <xsl:value-of select="(wd:Occupation)"/>
                    </Occupation>
                    <PayrollNumber>
                        <xsl:value-of select="(wd:Payroll_Number)"/>
                    </PayrollNumber>
                    <Location>
                        <xsl:value-of select="(wd:Location)"/>
                    </Location>
                    <LocationCode>
                        <xsl:value-of select="(wd:Location_Code)"/>
                    </LocationCode>
                    <Department>
                        <xsl:value-of select="(wd:Department)"/>
                    </Department>
                    <DepartmentCode>
                        <xsl:value-of select="(wd:Department_Code)"/>
                    </DepartmentCode>
                    <Division>
                        <xsl:value-of select="(wd:Division)"/>
                    </Division>
                    <MiscID>
                        <xsl:value-of select="(wd:Misc_ID)"/>
                    </MiscID>
                    <TermDate>
                        <xsl:value-of
                            select="format-date(wd:Termination_date, '[M01]/[D01]/[Y0001]')"/>
                    </TermDate>
                    <TermReason>
                        <xsl:value-of select="(wd:Termination_Reason)"/>
                    </TermReason>
                    <LOADate>
                        <xsl:value-of select="format-date(wd:LOA_Date, '[M01]/[D01]/[Y0001]')"/>
                    </LOADate>
                    <LOAReason>
                        <xsl:value-of select="(wd:LOA_Reason_Code)"/>
                    </LOAReason>
                    <SalaryChange>
                        <xsl:value-of
                            select="format-date(wd:Salary_Change_Date, '[M01]/[D01]/[Y0001]')"/>
                    </SalaryChange>
                    <FullPartTime xtt:required="true">
                        <xsl:value-of select="(wd:Full_Part_Time)"/>
                    </FullPartTime>
                    <RegTemp xtt:required="true">
                        <xsl:value-of select="(wd:Reg_Temp)"/>
                    </RegTemp>
                    <EmplStatus xtt:required="true">
                        <xsl:value-of select="(wd:Empl_Status)"/>
                    </EmplStatus>
                    <StdHours xtt:required="true">
                        <xsl:value-of select="(wd:Std_Hours)"/>
                    </StdHours>
                    <FTE xtt:required="true" xtt:severity="warning">
                        <xsl:value-of select="(wd:FTE)"/>
                    </FTE>
                    <OfficerCode xtt:required="true">
                        <xsl:value-of select="(wd:Officer_Code)"/>
                    </OfficerCode>
                    <Elig1>
                        <xsl:value-of select="(wd:Elig_1/@wd:descriptor)"/>
                    </Elig1>
                    <Elig2>
                        <xsl:value-of select="(wd:Elig_2)"/>
                    </Elig2>
                    <VisaPermit>
                        <xsl:value-of select="(wd:Visa_Permit_type)"/>
                    </VisaPermit>
                    <RetirementDate>
                        <xsl:value-of
                            select="format-date(wd:Retirement_Date, '[M01]/[D01]/[Y0001]')"/>
                    </RetirementDate>
                    <LTDEffdt>
                        <xsl:value-of select="format-date(wd:LTD_effdt, '[M01]/[D01]/[Y0001]')"/>
                    </LTDEffdt>
                    <DateOfDeath>
                        <xsl:value-of select="format-date(wd:Date_of_Death, '[M01]/[D01]/[Y0001]')"
                        />
                    </DateOfDeath>
                    <LOAReturn>
                        <xsl:value-of select="format-date(wd:LOA_Return, '[M01]/[D01]/[Y0001]')"/>
                    </LOAReturn>
                    <Elig_Chng_Date>
                        <xsl:value-of select="format-date(wd:Elig_Chng_Date, '[M01]/[D01]/[Y0001]')"/>
                    </Elig_Chng_Date>
                    <End>
                        <xsl:text>*</xsl:text>
                    </End>

                </Record>
                <!-- <xsl:value-of select="$linefeed"/> -->


            </xsl:for-each>
        </File>
    </xsl:template>
</xsl:stylesheet>
