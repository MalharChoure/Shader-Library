using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshRenderer))]
public class ShaderSwap : MonoBehaviour
{
    [SerializeField] private Material[] _mats;
    private MeshRenderer _meshRenderer;
    private int _currentMatId;
    void Start()
    {
        _meshRenderer = GetComponent<MeshRenderer>();
        _currentMatId = 0;
        _meshRenderer.material= _mats[_currentMatId];
    }

    void Update()
    {
        if(Input.GetKeyDown(KeyCode.W))
        {
            changeMatIncrement();
            Debug.Log(_currentMatId);
        }
        if (Input.GetKeyDown(KeyCode.S))
        {
            changeMatDecrement();
            Debug.Log(_currentMatId);
        }
    }

    private void changeMatIncrement()
    {
        if(_currentMatId<_mats.Length-1)
        {
            _currentMatId++;
        }
        _meshRenderer.material = _mats[_currentMatId];
    }

    private void changeMatDecrement()
    {
        if (_currentMatId > 0)
        {
            _currentMatId--;
        }
        _meshRenderer.material = _mats[_currentMatId];
    }
}
