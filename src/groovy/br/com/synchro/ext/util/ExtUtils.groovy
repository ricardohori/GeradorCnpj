package br.com.synchro.ext.util

import javax.management.monitor.StringMonitor

/**
 * <pre>
 * User: rfh
 * Date: 2/7/14
 * 
 * </pre>
 */
class ExtUtils {

    static Map<String, Object> decodeFilterParams(final Map pParams){
        final filters = pParams.findAll{ it.key ==~ /filter.+/}
        final groupedFilters = filters.groupBy {
            final iof = it.key.toString().indexOf("[")
            it.key.toString().charAt(iof + 1)
        }
        groupedFilters.collectEntries{k,v->
            final key = v.find{ it.key ==~ /.*field.*/}.value
            final value = v.find{ it.key ==~ /.*value.*/}.value

            [(key):value]
        } as Map<String, Object>
    }
}
