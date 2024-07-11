-- -----------------------------------------------------------------------------------	
-- Description: List a report of permissions that a user has
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col privilege for a200

SELECT
    privilege
FROM
    (
        SELECT
            1,
            username,
            CHR(10)
            || 'Username: '
            || username privilege
        FROM
            all_users
        WHERE
            username IN ( '&username' )
        UNION
        SELECT
            2,
            grantee,
            'System Privs : ' || privilege privilege
        FROM
            dba_sys_privs
        WHERE
            grantee IN ( '&username' )
        UNION
        SELECT
            3,
            grantee,
            'Role Privs : ' || granted_role privilege
        FROM
            dba_role_privs
        WHERE
            grantee IN ( '&username' )
        UNION
        SELECT
            4,
            grantee,
            'Tab Privs : '
            || owner
            || '.'
            || table_name
            || ' – '
            || privilege privilege
        FROM
            dba_tab_privs
        WHERE
            grantee IN ( '&username' )
        UNION
        SELECT
            5,
            grantee,
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
            grantee IN ( '&username' )
        ORDER BY
            2 ASC,
            1
    );