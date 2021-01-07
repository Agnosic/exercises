defmodule Information do
  @type t :: %__MODULE__{
          objects_count: pos_integer,
          objects_with_error_count: pos_integer,
          valid_objects: list
        }

  defstruct objects_count: 0, objects_with_error_count: 0, valid_objects: []
end
