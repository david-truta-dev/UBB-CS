import { ProductActionTypes, All } from '../actions/product.actions';
import { initialProductState, ProductState } from '../states/product.states';

export function reducer(
  state = initialProductState,
  action: All
): ProductState {
  switch (action.type) {
    // Create
    case ProductActionTypes.CREATEPRODUCT: {
      return {
        ...state,
        loading: true,
      };
    }
    case ProductActionTypes.CREATEPRODUCT_SUCCESS: {
      return {
        ...state,
        // todo: update product list?
        //products: action.payload.products,
        //selectedProduct: action.payload.selectedProduct,
        loading: false,
        errorMessage: null,
      };
    }
    case ProductActionTypes.CREATEPRODUCT_FAILURE: {
      return {
        ...state,
        loading: false,
        errorMessage: 'ERROR: Product could not be created.',
      };
    }
    // Read (one)
    case ProductActionTypes.GETPRODUCT: {
      return {
        ...state,
        loading: true,
      };
    }
    case ProductActionTypes.GETPRODUCT_SUCCESS: {
      return {
        ...state,
        selectedProduct: action.payload,
        loading: false,
        errorMessage: null,
      };
    }
    case ProductActionTypes.GETPRODUCT_FAILURE: {
      return {
        ...state,
        loading: false,
        errorMessage: 'ERROR: Product could not be retrieved.',
      };
    }
    // Read (all)
    case ProductActionTypes.GETPRODUCTS: {
      return {
        ...state,
        loading: true,
      };
    }
    case ProductActionTypes.GETPRODUCTS_SUCCESS: {
      return {
        ...state,
        products: action.payload,
        loading: false,
        errorMessage: null,
      };
    }
    case ProductActionTypes.GETPRODUCTS_FAILURE: {
      return {
        ...state,
        loading: false,
        errorMessage: 'ERROR: Products could not be retrieved.',
      };
    }
    // Update
    case ProductActionTypes.UPDATEPRODUCT: {
      return {
        ...state,
        loading: true,
      };
    }
    case ProductActionTypes.UPDATEPRODUCT_SUCCESS: {
      return {
        ...state,
        // todo: update product list?
        //products: action.payload.products,
        //selectedProduct: action.payload.selectedProduct,
        loading: false,
        errorMessage: null,
      };
    }
    case ProductActionTypes.UPDATEPRODUCT_FAILURE: {
      return {
        ...state,
        loading: false,
        errorMessage: 'ERROR: Product could not be updated.',
      };
    }
    // Delete
    case ProductActionTypes.DELETEPRODUCT: {
      return {
        ...state,
        loading: true,
      };
    }
    case ProductActionTypes.DELETEPRODUCT_SUCCESS: {
      return {
        ...state,
        // todo: update product list?
        //products: action.payload.products,
        //selectedProduct: action.payload.selectedProduct,
        loading: false,
        errorMessage: null,
      };
    }
    case ProductActionTypes.DELETEPRODUCT_FAILURE: {
      return {
        ...state,
        loading: false,
        errorMessage: 'ERROR: Product could not be deleted.',
      };
    }
    default: {
      return state;
    }
  }
}
