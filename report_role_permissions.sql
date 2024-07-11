-- -----------------------------------------------------------------------------------	
-- Description: List a report of permissions that a role has
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col privilege for a200

SELECT DISTINCT
    privilege
FROM
    (
        SELECT
            1,
            role    role,
            CHR(10)
            || 'Role: '
            || role privilege
        FROM
            dba_roles
        WHERE
            role IN (
                SELECT
                    granted_role privilege
                FROM
                    dba_role_privs
                WHERE
                    grantee IN ( '&role_name' )
            )
        UNION
        SELECT
            2,
            grantee                        role,
            'System Privs : ' || privilege privilege
        FROM
            dba_sys_privs
        WHERE
            grantee IN (
                SELECT
                    granted_role privilege
                FROM
                    dba_role_privs
                WHERE
                    grantee IN ( '&role_name' )
            )
        UNION
        SELECT
            3,
            grantee                         role,
            'Role Privs : ' || granted_role privilege
        FROM
            dba_role_privs
        WHERE
            grantee IN (
                SELECT
                    granted_role privilege
                FROM
                    dba_role_privs
                WHERE
                    grantee IN ( '&role_name' )
            )
        UNION
        SELECT
            4,
            grantee      role,
            'Tab Privs : '
            || owner
            || '.'
            || table_name
            || ' – '
            || privilege privilege
        FROM
            dba_tab_privs
        WHERE
            grantee IN (
                SELECT
                    granted_role privilege
                FROM
                    dba_role_privs
                WHERE
                    grantee IN ( '&role_name' )
            )
        UNION
        SELECT
            5,
            grantee      role,
            'Column Privs : '
            || owner
            || '.'
            || table_name
            || '.'
            || column_name
            || ' – '
            || privilege privilege
        FROM
            dba_col_privs
        WHERE
            grantee IN (
                SELECT
                    granted_role privilege
                FROM
                    dba_role_privs
                WHERE
                    grantee IN ( '&role_name' )
            )
        ORDER BY
            2 ASC,
            3
    );