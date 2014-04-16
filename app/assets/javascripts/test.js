/** @jsx React.DOM */



var ProductRow = React.createClass({displayName: 'ProductRow',
    render: function() {
        var name = this.props.product.public ?
            this.props.product.name :
            React.DOM.li( {style:{color: 'black'}}, 
                this.props.product.name
            );
        return (
            React.DOM.tr(null, 
                React.DOM.td(null, name),
                React.DOM.td(null, this.props.product.members)
            )
        );
    }
});

var ProductTable = React.createClass({displayName: 'ProductTable',
    render: function() {
        console.log(this.props);
        var rows = [];
        var lastCategory = null;
        this.props.products.forEach(function(product) {
            if (product.name.toLowerCase().indexOf(this.props.filterText.toLowerCase()) === -1 || (!product.public && this.props.inStockOnly)) {
                return;
            }
            rows.push(ProductRow( {product:product, key:product.name} ));
            lastCategory = product.category;
        }.bind(this));
        return (
            React.DOM.table(null, 
                React.DOM.thead(null, 
                    React.DOM.tr(null, 
                        React.DOM.th(null, "Poolnaam"),
                        React.DOM.th(null, "Leden")
                    )
                ),
                React.DOM.tbody(null, rows)
            )
        );
    }
});

var SearchBar = React.createClass({displayName: 'SearchBar',
    handleChange: function() {
        this.props.onUserInput(
            this.refs.filterTextInput.getDOMNode().value,
            this.refs.inStockOnlyInput.getDOMNode().checked
        );
    },
    render: function() {
        return (
            React.DOM.form( {onSubmit:this.handleSubmit}, 
                React.DOM.input(
                    {type:"text",
                    placeholder:"Zoeken...",
                    value:this.props.filterText,
                    ref:"filterTextInput",
                    onChange:this.handleChange}
                ),
                React.DOM.p(null, 
                    React.DOM.input(
                        {type:"checkbox",
                        value:this.props.inStockOnly,
                        ref:"inStockOnlyInput",
                        onChange:this.handleChange}
                    ),
                    "Alleen publieke pools tonen"
                ),
                React.DOM.p(null, 
                    React.DOM.input(
                        {type:"checkbox",
                        value:this.props.isFullOnly,
                        ref:"isFullOnlyInput",
                        onChange:this.handleChange}
                    ),
                    "Alleen beschikbare pools tonen"
                )
            )
        );
    }
});

var FilterableProductTable = React.createBackboneClass({displayName: 'FilterableProductTable',
    getInitialState: function() {
        return {
            filterText: '',
            inStockOnly: false
        };
    },
    
    handleUserInput: function(filterText, inStockOnly) {
        this.setState({
            filterText: filterText,
            inStockOnly: inStockOnly
        });
    },
    
    render: function() {
        return (
            React.DOM.div(null, 
                SearchBar(
                    {filterText:this.state.filterText,
                    inStockOnly:this.state.inStockOnly,
                    onUserInput:this.handleUserInput}
                ),
                ProductTable(
                    {products:this.props.products,
                    filterText:this.state.filterText,
                    inStockOnly:this.state.inStockOnly}
                )
            )
        );
    }
});


var PRODUCTS = [
  {category: 'Hogescholen', members: '16/16', public: true, full: true, name: 'NHL Hogeschool'},
  {category: 'Hogescholen', members: '5/32', public: true, full: false, name: 'Stenden University'},
  {category: 'Hogescholen', members: '54/64', public: false, full: false, name: 'Van Hal - Larenstijn'},
  {category: 'Hogescholen', members: '32/32', public: false, full: true, name: 'Vrije Universiteit Amsterdam'},
  {category: 'Hogescholen', members: '54/64', public: false, full: false, name: 'Technische Universiteit Groningen'},
  {category: 'Hogescholen', members: '54/64', public: false, full: false, name: 'Hanze Hogeschool'},
  {category: 'Hogescholen', members: '64/64', public: true, full: true, name: 'Kunstacademie Groningen'}
];
 
