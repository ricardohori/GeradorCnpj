Ext.Loader.setConfig({
    enabled: true
});


Ext.Loader.setPath('Ext.ux', 'js/vendor/extjs/ux');

Ext.require([
    'Ext.selection.CellModel',
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.state.*',
    'Ext.form.*',
    'Ext.ux.CheckColumn',
    'Ext.ux.grid.FiltersFeature',
    'Ext.toolbar.Paging',
    'Ext.ux.ajax.JsonSimlet',
    'Ext.ux.ajax.SimManager'
]);

Ext.onReady(function(){
    Ext.define('Writer.EstruturacaoBaseLegal', {
        extend: 'Ext.data.Model',
        fields: [
            {
                name: 'id',
                type: 'int',
                useNull: true
            },
            {
                name: 'obrigacao',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'identificadorOrgaoLegal',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'baseLegal',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'orgaoClassificador',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'fonte',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'linkFonte',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'responsavel',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'status',
                type: 'string',
                allowBlank: true
            },
            {
                name: 'componenteObrigacao',
                type: 'string',
                allowBlank: true
            }
        ],
        validations: []
    });

    var store = Ext.create('Ext.data.Store', {
        autoLoad: true,
        autoSync: true,
        pageSize: 31,
        model: 'Writer.EstruturacaoBaseLegal',
        proxy: {
            type: 'rest',
            url: 'api/estruturacaoBaseLegal',
            reader: {
                type: 'json',
                root: 'data',
                totalProperty: 'count',
                messageProperty: 'message'
            },
            writer: {
                type: 'json',
                root: 'data',
                encode: false
            },
            directionParam: 'order',
            sortParam: 'sort',
            limitParam: 'max',
            startParam: 'offset'
        }
    });

    var filters = {
        ftype: 'filters',
        // encode and local configuration options defined previously for easier reuse
        encode: false, // json encode the filter query,
        local: false
    };

    var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
        clicksToEdit: 1
    });

    // create the grid and specify what field you want
    // to use for the editor at each header.
    var grid = Ext.create('Ext.grid.Panel', {
        store: store,
        css:'white-space:normal;',
        columns: [{
            text: 'ID',
            width: 40,
            sortable: true,
            resizable: false,
            draggable: false,
            hideable: false,
            menuDisabled: true,
            dataIndex: 'id'
        }, {
            header: 'Obrigação',
            width: 100,
            sortable: true,
            dataIndex: 'obrigacao',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Órgão Legal',
            width: 150,
            sortable: true,
            dataIndex: 'identificadorOrgaoLegal',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Base Legal',
            width: 150,
            sortable: true,
            dataIndex: 'baseLegal',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Url Classificador',
            flex:1,
            sortable: true,
            dataIndex: 'orgaoClassificador',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Fonte',
            width: 100,
            sortable: true,
            dataIndex: 'fonte',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Link da fonte',
            flex:1,
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Responsavel',
            width: 80,
            sortable: true,
            dataIndex: 'responsavel',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }, {
            header: 'Status',
            width: 100,
            sortable: true,
            dataIndex: 'status',
            field: {
                type: 'textfield'
            },
            filter: {
                type: 'string'
            }
        }],
        selModel: {
            selType: 'cellmodel'
        },
        // paging bar on the bottom
        bbar: Ext.create('Ext.PagingToolbar', {
            store: store,
            displayInfo: true,
            displayMsg: 'Displaying topics {0} - {1} of {2}',
            emptyMsg: "No topics to display"
        }),
        renderTo: 'grid-base-legal',
        width: 1500,
        height: 750,
        title: 'Bases legais utilizadas em obrigações',
        frame: true,
        plugins: [cellEditing],
        features: [filters]
    });
});