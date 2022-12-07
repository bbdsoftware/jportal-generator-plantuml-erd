<#function getPythonType apply_to_pk field >
<#-- @ftlvariable name="field" type="bbd.jportal2.Field" -->
    <#if field.enums?size gt 0><#return "${field.name}Enum"></#if>
    <#assign prefix = ''>
    <#assign suffix = ''>

    <#if field.isNull() || (apply_to_pk && field.isPrimaryKey())>
        <#assign prefix = ''>
        <#assign suffix = ''>
    </#if>

    <#if field.type?c == '1'><#return prefix + "Any" + suffix>
    <#elseif field.type?c == '2'><#return prefix + "bool" + suffix>
    <#elseif field.type?c == '3'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '4'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '5'><#return prefix + "datetime" + suffix>
    <#elseif field.type?c == '6'><#return prefix + "datetime" + suffix>
    <#elseif field.type?c == '7'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '9'><#return prefix + "float" + suffix>
    <#elseif field.type?c == '10'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '11'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '12'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '13'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '14'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '15'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '17'><#return prefix + "datetime" + suffix>
    <#elseif field.type?c == '18'><#return prefix + "datetime" + suffix>
    <#elseif field.type == STATICS.Field.TLOB><#return prefix + "str" + suffix>
    <#elseif field.type?c == '20'><#return prefix + "datetime" + suffix>
    <#elseif field.type?c == '21'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '23'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '24'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '25'><#return prefix + "int" + suffix>
    <#elseif field.type?c == '26'><#return prefix + "datetime" + suffix>
    <#elseif field.type?c == '27'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '28'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '29'><#return prefix + "str" + suffix>
    <#elseif field.type?c == '30'><#return prefix + "str" + suffix>
    <#elseif field.type == STATICS.Field.JSON><#return prefix + "str" + suffix>
    <#elseif field.type == STATICS.Field.BIGJSON><#return prefix + "str" + suffix>

    <#else><#return prefix + "str" + suffix>
    </#if>>
</#function>
!theme cerulean
@startuml ${database.name}
' hide the spot
hide circle

' avoid problems with angled crows feet
skinparam linetype ortho

<#list database.getTables() as table>
entity "${table.name}" as ${table.name} {
  <#list table.getFields() as field>
    <#if field.isPrimaryKey()>
  *${field.name} : <#compress>${getPythonType(false, field)}</#compress><#if table.getLinkForField(field)??> <<FK>></#if>
    </#if>
  </#list>
  --
  <#list table.getFields() as field>
    <#if !field.isPrimaryKey()>
    <#if !field.isNull()>*</#if>${field.name} : <#compress>${getPythonType(false, field)}</#compress> 
    </#if>
  </#list>

}
</#list>

<#list database.getTables() as table>
  <#list table.getLinks() as link>
        <#--  <#if link.getName() != table.name>  -->
${table} }o-- ${link.getName()}::${link.getFirstLinkField()}
        <#--  </#if>  -->
  </#list>
</#list>

@enduml